#!/opt/local/bin/perl -l
use strict;

use HTML::Tree;
use LWP::Simple;
use Data::Dumper;
use DBI;
use JSON;
use Tie::IxHash;
use List::Util;
use Getopt::Long;

my $remote = '';

GetOptions(
	'remote'   => \$remote
);


#Try to connect to the database
#LOCAL DB
my $schema = q{ff};
my $dbi = q{dbi:mysql:database=ff;host=localhost};
my $user = "root";
my $pwd  = "nasty1";

#FANTEDGE DB
if($remote) {
    $schema = q{scratch};
    $dbi = q{dbi:mysql:database=scratch;host=127.0.0.1};
    $user = "frank";
    $pwd = "dri8kei";
}

#-------------------------------- GLOBAL VARIABLES -------------------------------- 

my $dbh = DBI->connect($dbi,$user,$pwd) or die "Connection Error: $DBI::errstr\n";			#DB Handle
my $depth = {};
my @positions = ('QB','RB','FB','WR','TE','K');												#Points scoring positions
my @injuries  = ('PUP','IR','NFI');

#-----------------------------   END GLOBAL VARIABLES ------------------------------ 

# Load the depth chart for RBs into the global $depth hashRef - bad frank!
load_depth(q{http://www.cbssports.com/fantasy/football/depth-chart/QB/});   #QB Depth Chart
load_depth(q{http://www.cbssports.com/fantasy/football/depth-chart/RB/});	#RB Depth Chart
load_depth(q{http://www.cbssports.com/fantasy/football/depth-chart/WR/});	#WR Depth Chart
load_depth(q{http://www.cbssports.com/fantasy/football/depth-chart/TE/});	#TE Depth Chart
load_depth(q{http://www.cbssports.com/fantasy/football/depth-chart/K/});	#K Depth Chart

#Load the injury data into the global $depth hashRef - bad frank!
load_injuries(q{http://www.cbssports.com/nfl/injuries});
load_injuries(q{http://www.cbssports.com/nfl/injuries/pup});

#Get the games for the current week
my $games = get_current_week();

foreach my $game (@$games) {
	my ($gameId, $week, $g_mnemonic, $homeTeam, $awayTeam) = @$game;
	
	print "################################   $g_mnemonic    ###############";    
	
	#Reset the injuries for every player in the game
	update_row(q{update nfl_player_game_info set injuryStatus=null, injuryDetail=null, injuryNotes=null where gameId=?},$gameId);
	
	#Load the homeTeam Data
	load_player_data($homeTeam, $gameId, $g_mnemonic, $week);
	
	#Load the awayTeam Data
	load_player_data($awayTeam, $gameId, $g_mnemonic, $week);

	
}

#Load data

#Load the data into the database
#print Dumper($depth);

#----------------------------------------------------------------------------------------------
#                                       Methods
#----------------------------------------------------------------------------------------------

#Loads variable data points for individual player for the week including current depth, injuries, and salaries from FD, DK, and Yahoo
sub load_player_data {
	my($team, $gameId, $g_mnemonic, $week) = @_;

	my $players = $depth->{$team};
	
	foreach my $player (@$players) {
		unless ($player->{playerId}) {
			print Dumper($player);
			next;
		}
		
		my $sql = q{replace into nfl_player_game_info set gameId = ?, playerId = ?, g_mnemonic = ?, p_mnemonic = ?, week = ?, position = ?, `depth` = ?, injuryStatus = ?, injuryDetail = ?, injuryNotes = ?, DKsalary = ?, FDsalary = ?, YHsalary = ?};
		
		replace_row($sql,
			$gameId,
			$player->{playerId},
			$g_mnemonic,
			$player->{p_mnemonic},
			$week,
			$player->{position},
			$player->{depth} || undef,
			$player->{injuryStatus} || undef,
			$player->{injuryDetail} || undef,
			$player->{injuryNotes} || undef,
			undef,
			undef,
			undef
		);
	}
	
	
}

sub get_current_week {
	#Current week is all of the games for the week in which there are still games to play
	my $sql = q{select gameId, week, mnemonic, homeTeamId, awayTeamId from nfl_schedule where week = (select week from nfl_schedule where gametime > CURDATE() order by gametime limit 1)};
	return fetchall_arrayref($sql);
}

#Load the injuries
sub load_injuries {
	my ($url)   = @_;
	
	my $tree = load_content($url);
	
    my @tables = $tree->look_down(
        _tag  => q{div},
        class => q{column1}
    )->content_list();
	
	foreach my $table (@tables) {
		next unless ref $table eq "HTML::Element";
		my @rows  = $table->content_list();
		next if ($table->attr('class') ne "data" || $table->tag ne "table" || $table->is_empty() || scalar(@rows) == 0);
		
		#Team is in the url of the first row.  Shift it off and extract the team name.
		my $title = shift(@rows);
		$title->look_down( _tag => q{a} )->attr('href') =~ /\/nfl\/teams\/page\/(\w+)\/.*/;
		my $team = $1;
		
		#Add the team array if it doesn't already exist
		$depth->{$team} = [] unless(exists $depth->{$team});
		extract_injuries($team,\@rows);
		
	}
}

sub getPlayerHash {
	my ($team, $playerUrl) = @_;
	
	#if($playerUrl =~ /1824731/) {
	#	print $team." ~~ ".$playerUrl;
	#}
	
	#Try to find the player in the existing hash
	my $players = $depth->{$team};
	foreach my $player (@$players) {
		return $player if ($player->{playerUrl} eq $playerUrl);
	}
	
	#Extract the playerId to see if we need to add the player or if we already have him
	$playerUrl =~ /\/nfl\/players\/playerpage\/(\d+)\/.*/;
	my $id = $1;
	
	#Look up the user in the database.  Try to add the user if not found
    my $playerData = fetchrow_array('SELECT playerId, mnemonic, position, cbsPlayerUrl FROM nfl_player WHERE cbsPlayerUrl like ? and teamId=? order by dateCreated desc limit 1',"%".$id."%",$team);

	#Check the hash one more time because sometimes CBS Sports has different urls for the same damn player - this seems inefficient, but it's better than running the query for every player
	my $players = $depth->{$team};
	foreach my $player (@$players) {
		return $player if ($player->{playerUrl} eq $playerData->[3]);
	}

	if ( scalar(@{$playerData}) == 0  ) {
		print "Could not find player $playerUrl on team $team.  Trying to add...";
		$playerData = updatePlayerProfile($playerUrl,$team);
		unless (scalar(@{$playerData})) {
			print "Couldn't find player $playerUrl on team $team.  Giving up - go see what is up on CBS Sports";
			return {};
		}
	}
	
	my $playerHash = {
		playerId   => $playerData->[0],
		p_mnemonic => $playerData->[1],
		position   => $playerData->[2],
		playerUrl  => $playerData->[3]
	};
	
	#if($playerUrl =~ /1824731/) {
	#	print Dumper($playerHash);
	#}
	
	push(@{$depth->{$team}},$playerHash);
	
	return $playerHash;
}

sub extract_injuries {
	my ($team, $rows) = @_;
	
	#First row is a header row, remove it
	shift @$rows;
	
	foreach my $row (@$rows) {
		my @tdata = $row->content_list();
		next unless scalar(@tdata) > 1;  # Skip the teams that do not have injuries
		#Second column is the position - only keep points scoring positions (QB, RB, FB, WR, TE, K)
		my $position = $tdata[1]->as_trimmed_text;
		next unless ($position ~~ @positions);
		
		#Third column is the player - look him up
		my @playerNodes = $tdata[2]->content_list();
		my $playerUrl = $playerNodes[0]->attr('href');
		
		my $playerHash = getPlayerHash($team, $playerUrl);
		next unless (exists $playerHash->{playerId});
		
		$playerHash->{injuryStatus} = $tdata[4]->as_trimmed_text;
		unless ($playerHash->{injuryStatus} ~~ @injuries) {
			$playerHash->{injuryStatus} = substr($playerHash->{injuryStatus}, 0, 1);
		}
		
		my $idetail = $tdata[3]->as_trimmed_text;
		if($idetail ne "") {
			$playerHash->{injuryDetail} = $idetail;
		}
		
		if($tdata[5]) {
			$playerHash->{injuryNotes} = $tdata[5]->as_trimmed_text;
		}
		
	}
	
	
	
}

#Get the content from a webpage and load into an HTML::Tree for parsing
sub load_content {
	my $url = shift;
	#Load the content from the url passed in
    my $content = get($url);
    my $tree = HTML::Tree->new();
    $tree->parse($content);
	return $tree;
}

#Load the depth chart from a url
sub load_depth {
	my ($url)   = @_;
	
	my $tree = load_content($url);
	
    my @rows = $tree->look_down(
        _tag  =>  q{table},
        class => q{data}
    )->content_list();
	
	foreach my $row (@rows) {
		next unless ($row->attr('class') =~ /row\d/);
		my @tdata   = $row->content_list();
		my $firstcol = shift(@tdata);
		my $team    = $firstcol->as_trimmed_text;
		$depth->{$team} = [] unless(exists $depth->{$team});
		for(my $i= 0; $i < scalar(@tdata); $i++) {
			extract_players($team, $tdata[$i],($i+1));
		}
	}
}


sub extract_players {
	my ($team, $node, $d) = @_;
	my @innerNodes = $node->content_list();
	
	foreach my $n (@innerNodes) {
		next unless (ref $n eq "HTML::Element" && $n->tag eq "a");
		$n->attr('href') =~ /\/fantasy\/football\/players\/(.*)/;
		my $playerUrl = qq{/nfl/players/playerpage/$1};
		
		my $playerHash = getPlayerHash($team, $playerUrl);
		
		next unless (exists $playerHash->{playerId});
		
		$playerHash->{depth} = $d;
		
		#if($playerUrl =~ /1824731/) {
		#	print Dumper($playerHash); 
		#}
	}
}

#-----------------------------------------SQL--------------------------------------------------

sub fetchrow_array {
    my $sql = shift;
    my @params = @_;
    
    my $sth = $dbh->prepare($sql);
    $sth->execute(@params);
    my @result = $sth->fetchrow_array();
    $sth->finish;
    
    return \@result;
}

sub fetchall_arrayref {
    my $sql = shift;
    my @params = @_;
    
    my $sth = $dbh->prepare($sql);
    $sth->execute(@params);
    my $result = $sth->fetchall_arrayref([]);
    $sth->finish;
    
    return $result;
}

sub replace_row {
	insert_row(@_);
}

sub delete_row {
    insert_row(@_);
}

sub update_row {
    insert_row(@_);
}

sub insert_row {
    my $sql = shift;
    my @params = @_;
    #print "running $sql with data ".join(",",@params);
    my $sth = $dbh->prepare($sql);
    $sth->execute(@params);
    $sth->finish;
    
}

#-----------------------------------------Shared--------------------------------------------------
# this is copypasta from loadstats.pl - should have made a package for this but i'm lazy like that and this thing will only be in use for a short period of time.

sub updatePlayerProfile {
    my $link = shift;
	my $inteam = shift;
    
    my $url = q{http://www.cbssports.com}.$link;
    
    #Build the page tree
    my $content = get($url);
    my $pTree = HTML::Tree->new();
    $pTree->parse($content);
    
    #Parse the following
    #<div class="photo"><img src="http://sports.cbsimg.net/images/football/nfl/players/60x80/419780.jpg" border="0" Alt="player photo" width="60" height="80"></div>
    #<div class="name">
        #<h1><span class="jerseyNumber">12</span> <span class="firstName">Aaron</span> Rodgers <span class="playerPosition">QB</span></h1>
        #<h3 class="superText"><a href="/nfl/teams/page/GB/green-bay-packers">Green Bay Packers</a></h3>
    #</div>
    
    #Parse the name element containing the jersey, name, position, and team ID
    my $pInfo = $pTree->look_down(
        _tag => q{div},
        class => q{name}
    );
    
    #Start by getting the Team ID which is part of the url
    my $team = $pInfo->look_down(
        _tag => q{h3},
        class => q{superText}
    )->look_down( _tag=>q{a})->attr('href');

    $team =~ qr/\/nfl\/teams\/page\/(\w+)\/*/;    
    
    my $teamId = $1;
	
	if($inteam && $inteam ne $teamId) {
		return [];  #Player doesn't match his team online - skip this guy
		#print $inteam." ~~ ".$teamId;
		#Data isn't udpated on the site, skip this guy he is probably not even in the league anymore - won't have any real stats to speak about.
		#print "Player $link does not match his team online.  Something is up.  Skip it.";
		#Extract the playerId to see if we need to add the player or if we already have him
		#$link =~ /\/nfl\/players\/playerpage\/(\d+)\/.*/;
		#my $id = $1;
		#print "id: ".$id;
		#my $result = fetchrow_array("select playerId, teamId, mnemonic, firstName, lastName from nfl_player where cbsPlayerUrl like ? and teamId=? order by dateCreated desc limit 1","%".$id."%", $teamId);
		#print "Player $id not updated on injury page ... returning correct info ".Dumper([$result->[0], $result->[1], $result->[2], $result->[3], $result->[4]]);
		#return [$result->[0], $result->[1], $result->[2], $result->[3], $result->[4]];
	}
    
    #Next get the jersey, name, and position
    my $name = $pInfo->look_down(
        _tag => q{h1}
    );
    
    my @nameParts = $name->content_list();
    #The first HTML::Element is the Jersey Number
    #The second HTML::Element is the First Name
    #The third HTML::Element is the Position
    #The first non element with text is the Last Name
    my $firstName = "";
    my $lastName = "";
    my $position = "";
    my $jersey = "";
    
    my $count = 1;
    foreach my $part (@nameParts) {
        if(ref $part eq "HTML::Element") {
            if($count == 1) {
                $jersey = $part->as_trimmed_text;
            }
            elsif ($count == 2) {
                $firstName = $part->as_trimmed_text;
            }
            elsif($count == 3) {
                $position = $part->as_trimmed_text;
                if(length($position) > 3) {
                    ($position, my $junk) = split("/",$position);
                }
            }
            $count++;
            next;
        }
        
        if($part =~ qr/\w/){
            $lastName = trim($part);
        }
    }
    
    #Create the mnemonic by concatenating lowercase first name,last name, team, and position with an underscore.
    my $mnemonic = lc($firstName)."_".lc($lastName)."_".$teamId."_".$position;
    #Player current status not on this page.  Set it to Active.
    my $status = "A";
    
    
    #now get the photo url
    my $photoUrl = $pTree->look_down(
        _tag => q{div},
        class => q{photo}
    )->look_down(
        _tag => q{img}
    )->attr('src');
    
    
    insert_row(q{
        insert into nfl_player
            (playerId, teamId, firstName, lastName, mnemonic, position, status, cbsPlayerUrl, photoUrl,dateCreated)
            values
            (?,?,?,?,?,?,?,?,?,CURDATE())
        },
        ('1',$teamId,$firstName,$lastName,$mnemonic,$position,$status,$link,$photoUrl)
    );
    
    my $result = fetchrow_array("select playerId from nfl_player where cbsPlayerUrl=? order by dateCreated desc limit 1",$link);
    
    if ( scalar(@{$result}) == 0 ) {
            print "Could not add player $link to the database ... skipping";
            return [];
    }
    
    print $result->[0]." added to the database";
    
    return [$result->[0], $teamId, $mnemonic, $firstName, $lastName];

}

sub trim {
    my $str = shift;
    $str =~ s/^\s+|\s+$//g;
    return $str;
}

