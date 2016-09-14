#!/opt/local/bin/perl -l
use strict;

use HTML::Tree;
use LWP::Simple;
use Data::Dumper;
use DBI;
use Getopt::Long;
use FF;
use FF::SQL;

my $remote = '';
my @weeks;

GetOptions(
	'remote'   => \$remote,
	'week=s'   => \@weeks,
);

unless ( scalar(@weeks) > 0 ) {
    print "Please tell me which weeks you want loaded using the --week=x flag";
    exit;
}

#Try to connect to the database
#LOCAL DB
my $dbi = q{dbi:mysql:database=ff2016;host=localhost};
my $user = "root";
my $pwd  = "nasty1";

#FANTEDGE DB
if($remote) {
    $dbi = q{dbi:mysql:database=scratch;host=127.0.0.1};
    $user = "frank";
    $pwd = "dri8kei";
    #$dbh = DBI->connect($dbi,'frank','dri8kei') or die "Connection Error: $DBI::errstr\n";
}

my $db = FF::SQL->connect($dbi,$user,$pwd) or die "Connection Error: $DBI::errstr\n";
my $ff = FF->new();

#Testing Passing
#my $g_mnemonic = q{NFL_20151011_STL@GB};
#my $g_mnemonic = q{NFL_20151011_JAC@TB};

#Testing Passing 2pt conv
#my $g_mnemonic = q{NFL_20150927_PIT@STL};
#my $g_mnemonic = q{NFL_20150920_SF@PIT};

#Testing Rushing and 2pt conv
#my $g_mnemonic = q{NFL_20151004_KC@CIN};
#my $g_mnemonic = q{NFL_20150920_DET@MIN};

#Testing Kick Off return TD
#my $g_mnemonic = q{NFL_20150920_ARI@CHI};

#Testing Punt Return TDs and Fumble Return TD
#my $g_mnemonic = q{NFL_20150913_SEA@STL};

#Testing Special Teams TD and on the Fumble Lost/Rec list and Special Teams TD and no other stats
#my $g_mnemonic = q{NFL_20150927_NO@CAR};

#Testing Safties and INT TDs
#my $g_mnemonic = q{NFL_20150927_SF@ARI};

#Blocked Punt
#my $g_mnemonic = q{NFL_20150924_WAS@NYG};

#Blocked XP
#my $g_mnemonic = q{NFL_20150927_DEN@DET};

my $week_str = join(",",@weeks);

my $games = fetchall_arrayref(qq{select mnemonic from nfl_schedule where week in ($week_str)});

foreach my $gameRef (@{$games}) {
    my $g_mnemonic = $gameRef->[0];
    
    print "################################   $g_mnemonic    ###############";    
    
    
    #Get the CBS Page we want to retrieve
    my $statsPage = q{http://www.cbssports.com/nfl/gametracker/live/}.$g_mnemonic;
    
    #Look up the game in the database
    
    my $result = fetchrow_array('SELECT gameId FROM nfl_schedule WHERE mnemonic=?',$g_mnemonic);
    unless ( scalar(@{$result}) ) {
        print "Could not find the game $g_mnemonic .  Please check the database";
        exit(0);
    }
    
    #Store the gameID
    my $gameId = $result->[0];
    
    #Load the content
    my $content = get($statsPage);
    my $tree = HTML::Tree->new();
    $tree->parse($content);
    
    #Update the score
    my $aScore = $tree->look_down(
        _tag  =>  q{div},
        class => q{hud-team away}
    )->look_down(
        _tag  => q{div},
        class => q{score}
    )->as_trimmed_text;
    
    
     my $hScore = $tree->look_down(
        _tag  =>  q{div},
        class => q{hud-team home}
    )->look_down(
        _tag  => q{div},
        class => q{score}
    )->as_trimmed_text;
    
    update_row("update nfl_schedule set aScore=?, hScore=? where gameId=?",$aScore,$hScore,$gameId);
    
    #Load the Scoring Summary
    my @scoring = $tree->look_down(
        _tag  => q{div},
        id    => q{scoring-summary}
    )->look_down(
        _tag  => q{span},
        class => q{time}
    );
    
    
    my $spTmTds = {};
    
    #----------------------------------------------------------------------------------------------
    #                                       Passing
    #----------------------------------------------------------------------------------------------
    
    #Load the passing stats
    my @passings = $tree->look_down(
        _tag  => q{span},
        class => qr/pStats00|pStats10/
    );
    
    #Clean up - Delete old passing data
    delete_row("delete from nfl_passing_stats where g_mnemonic=?",$g_mnemonic);
    
    print "#---------------PASSING----------------------";
    
    foreach my $passing (@passings) {
        
        my @rows = $passing->look_down( _tag => q{tr} );
        #first row is column headers - get rid of it.
        shift @rows;
        
        foreach my $row (@rows) {
            
            my @passingStats = ('1',undef,undef,$gameId,undef,$g_mnemonic,undef,undef,undef,undef,undef,0,undef);
            my $player_name;
            
            my @cols = $row->look_down( _tag => q{td} );
            for (my $i = 0; $i < scalar(@cols); $i++) {
      
                my $col = $cols[$i];
                #First column is the player.  Let's add him to the DB if he doesn't exist
                if ($i == 0) {
                    my $a = $col->look_down( _tag=>q{a});
                    my $link = $a->attr('href');
                    $result = undef;
                    
                    #Look up the user in the database.  Add the user if not found
                    $link =~ /\/nfl\/players\/playerpage\/(\d+)\/.*/;
                    my $id = $1;
                    $result = fetchrow_array('SELECT playerId, teamId, mnemonic, firstName, lastName FROM nfl_player WHERE cbsPlayerUrl like ? order by dateCreated desc limit 1',"%".$id."%");
                    my $currTm = $result->[1];
                    if ( scalar(@{$result}) == 0 || $g_mnemonic !~ /$currTm/ ) {
                        print "Could not find player $link .  Adding to the database";
                        $result = updatePlayerProfile($link);
                        
                        if( scalar(@{$result}) == 0 ) {
                            print "Could not add passing stats for $link  Please try again";
                        }
                    }
                    
                    $player_name     = $result->[3]." ".$result->[4];
                    $passingStats[1] = $result->[0];
                    $passingStats[2] = $result->[1];
                    $passingStats[4] = $result->[2];
                    next;
                }
                #Second column is in the format cmp/att
                elsif ($i == 1) {
                    ($passingStats[7],$passingStats[6]) = split("/",$col->as_trimmed_text);
                }
                #Third column is yards
                elsif($i == 2) {
                    $passingStats[8] = $col->as_trimmed_text;
                    $passingStats[12] = ($passingStats[8] >= 300) ? 1 : 0;
                }
                #Fourth Column is TDs
                elsif($i == 3) {
                    $passingStats[9] = $col->as_trimmed_text;
                }
                #Fifth Column is INTs
                elsif($i == 4) {
                    $passingStats[10] = $col->as_trimmed_text;
                }
                
            }
            
            #Check for 2pt conversion passes
            foreach my $scoring (@scoring) {
                my $scoring_txt = $scoring->parent->as_text;
                if ($scoring_txt =~ /\($player_name passes to \w+\s\w+ for a 2 Pt. Conversion\)/) {
                    $passingStats[11]++;
                }
            }
            
            print $player_name;
            print Dumper(@passingStats);
            
            #Insert into the passing stats
            #insert_row(q{
            #    insert into nfl_passing_stats
            #        (statId, playerId, teamId, gameId, p_mnemonic, g_mnemonic, att, cmp, yrd, td, `int`,`2pt`,`300gm`)
            #        values
            #        (?,?,?,?,?,?,?,?,?,?,?,?,?)
            #    },
            #    @passingStats
            #);
        
        }
    }
    

}


#----------------------------------------------------------------------------------------------
#                                       Methods
#----------------------------------------------------------------------------------------------


sub updatePlayerProfile {
    my $link = shift;
    
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
            (playerId, teamId, firstName, lastName, mnemonic, position, status, cbsPlayerUrl, photoUrl, dateCreated)
            values
            (?,?,?,?,?,?,?,?,?,CURDATE())
        },
        ('1',$teamId,$firstName,$lastName,$mnemonic,$position,$status,$link,$photoUrl)
    );
    
    my $result = fetchrow_array("select playerId from nfl_player where cbsPlayerUrl=? order by dateCreated desc limit 1",$link);
    
    if ( scalar(@{$result}) == 0 ) {
            print "Could not add player $link to the database ... skipping";
            return undef;
    }
    
    print $result->[0]." added to the database";
    
    return [$result->[0], $teamId, $mnemonic, $firstName, $lastName];

}


