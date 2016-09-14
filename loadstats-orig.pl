#!/opt/local/bin/perl -l
use strict;

use HTML::Tree;
use LWP::Simple;
use Data::Dumper;
use DBI;
use Getopt::Long;

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
my $dbi = q{dbi:mysql:database=ff;host=localhost};
my $user = "root";
my $pwd  = "nasty1";

#FANTEDGE DB
if($remote) {
    $dbi = q{dbi:mysql:database=scratch;host=127.0.0.1};
    $user = "frank";
    $pwd = "dri8kei";
    #$dbh = DBI->connect($dbi,'frank','dri8kei') or die "Connection Error: $DBI::errstr\n";
}

my $dbh = DBI->connect($dbi,$user,$pwd) or die "Connection Error: $DBI::errstr\n";


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
            insert_row(q{
                insert into nfl_passing_stats
                    (statId, playerId, teamId, gameId, p_mnemonic, g_mnemonic, att, cmp, yrd, td, `int`,`2pt`,`300gm`)
                    values
                    (?,?,?,?,?,?,?,?,?,?,?,?,?)
                },
                @passingStats
            );
        
        }
    }
    
    
    #----------------------------------------------------------------------------------------------
    #                                       Rushing
    #----------------------------------------------------------------------------------------------
    
    #Load the rushing stats
    my @rushings = $tree->look_down(
        _tag  => q{span},
        class => qr/pStats01|pStats11/
    );
    
    #Clean up - Delete old rushing data
    delete_row("delete from nfl_rushing_stats where g_mnemonic=?",$g_mnemonic);
    
    print "#---------------RUSHING----------------------";
    
    foreach my $rushing (@rushings) {
        
        my @rows = $rushing->look_down( _tag => q{tr} );
        #first row is column headers - get rid of it.
        shift @rows;
        
        foreach my $row (@rows) {
            
            my @rushingStats = ('1',undef,undef,$gameId,undef,$g_mnemonic,undef,undef,undef,0,undef);
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
                            print "Could not add rushing stats for $link  Please try again";
                        }
                    }
                    
                    $player_name     = $result->[3]." ".$result->[4];
                    $rushingStats[1] = $result->[0];
                    $rushingStats[2] = $result->[1];
                    $rushingStats[4] = $result->[2];
                    next;
                }
                #Second column is att
                elsif ($i == 1) {
                    $rushingStats[6] = $col->as_trimmed_text;
                }
                #Third column is yards
                elsif($i == 2) {
                    $rushingStats[7] = $col->as_trimmed_text;
                    $rushingStats[10] = ($rushingStats[7] >= 100) ? 1 : 0;
                }
                #Fourth Column is TDs
                elsif($i == 3) {
                    $rushingStats[8] = $col->as_trimmed_text;
                }
                
            }
            
            #Check for 2pt conversion passes and special teams TDs
            foreach my $scoring (@scoring) {
                my $scoring_txt = $scoring->parent->as_text;
                if ($scoring_txt =~ /\($player_name runs for a 2 Pt. Conversion\)/) {
                    $rushingStats[9]++;
                }
                
                if ($scoring_txt =~ /$player_name makes \d+ yard kick return/) {
                    $spTmTds->{$rushingStats[1]}++;
                }
                
                if ($scoring_txt =~ /$player_name makes \d+ yard punt return/) {
                    $spTmTds->{$rushingStats[1]}++;
                }
            }
            
            print $player_name;
            print Dumper(@rushingStats);
            
            #Insert into the passing stats
            insert_row(q{
                insert into nfl_rushing_stats
                    (statId, playerId, teamId, gameId, p_mnemonic, g_mnemonic, att, yrd, td, `2pt`,`100gm`)
                    values
                    (?,?,?,?,?,?,?,?,?,?,?)
                },
                @rushingStats
            );
        
        }
    }
    
    
    
    #----------------------------------------------------------------------------------------------
    #                                       Receiving
    #----------------------------------------------------------------------------------------------
    
    #Clean up - Delete old receiving data
    delete_row("delete from nfl_receiving_stats where g_mnemonic=?",$g_mnemonic);
    
    #Load the receiving stats
    my @receivings = $tree->look_down(
        _tag  => q{span},
        class => qr/pStats02|pStats12/
    );
    
    print "#---------------RECEIVING----------------------";
    
    foreach my $receiving (@receivings) {
        
        my @rows = $receiving->look_down( _tag => q{tr} );
        #first row is column headers - get rid of it.
        shift @rows;
        
        foreach my $row (@rows) {
            
            my @receivingStats = ('1',undef,undef,$gameId,undef,$g_mnemonic,undef,undef,undef, undef,0,undef);
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
                            print "Could not add receiving stats for $link  Please try again";
                        }
                    }
                    
                    $player_name     = $result->[3]." ".$result->[4];
                    $receivingStats[1] = $result->[0];
                    $receivingStats[2] = $result->[1];
                    $receivingStats[4] = $result->[2];
                    next;
                }
                #Second column is targets
                elsif ($i == 1) {
                    $receivingStats[6] = $col->as_trimmed_text;
                }
                #Third column is receptions
                elsif($i == 2) {
                    $receivingStats[7] = $col->as_trimmed_text;
                }
                #Fourth column is yards
                elsif($i == 3) {
                    $receivingStats[8] = $col->as_trimmed_text;
                    $receivingStats[11] = ($receivingStats[8] >= 100) ? 1 : 0;
                }
                #Fifth Column is TDs
                elsif($i == 4) {
                    $receivingStats[9] = $col->as_trimmed_text;
                }
                
            }
            
            #Check for 2pt conversion passes and special teams TDs
            my $counter = 0;
            foreach my $scoring (@scoring) {
                my $scoring_txt = $scoring->parent->as_text;
                if ($scoring_txt =~ /\(\w+\s\w+ passes to $player_name for a 2 Pt. Conversion\)/) {
                    $receivingStats[10]++;
                }
                
                #Skip Special Teams if records already exist when we enter.  That means we've already processed
                #for this person in one of the other offensive areas.  Don't enter or we'll have too many special teams credits
                next if($counter == 0 && exists $spTmTds->{$receivingStats[1]});
                
                if ($scoring_txt =~ /$player_name makes \d+ yard kick return/) {
                    $spTmTds->{$receivingStats[1]}++;
                }
                
                if ($scoring_txt =~ /$player_name makes \d+ yard punt return/) {
                    $spTmTds->{$receivingStats[1]}++;
                }
                
                $counter++;
            }
            
            print $player_name;
            print Dumper(@receivingStats);
            
            #Insert into the passing stats
            insert_row(q{
                insert into nfl_receiving_stats
                    (statId, playerId, teamId, gameId, p_mnemonic, g_mnemonic, tgt, recpt, yrd, td, `2pt`,`100gm`)
                    values
                    (?,?,?,?,?,?,?,?,?,?,?,?)
                },
                @receivingStats
            );
        
        }
    }
    
    
    #----------------------------------------------------------------------------------------------
    #                                       Misc
    #----------------------------------------------------------------------------------------------
    
    #Clean up - Delete old receiving data
    delete_row("delete from nfl_misc_stats where g_mnemonic=?",$g_mnemonic);
    
    #Load the misc stats
    my @miscs = $tree->look_down(
        _tag  => q{span},
        class => qr/pStats03|pStats13/
    );
    
    print "#---------------MISC----------------------";
        
    
    foreach my $misc (@miscs) {
        
        my @rows = $misc->look_down( _tag => q{tr} );
        #first row is column headers - get rid of it.
        shift @rows;
        
        foreach my $row (@rows) {
            
            my @miscStats = ('1',undef,undef,$gameId,undef,$g_mnemonic,undef,undef);
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
                            print "Could not add receiving stats for $link  Please try again";
                        }
                    }
                    
                    $player_name     = $result->[3]." ".$result->[4];
                    $miscStats[1] = $result->[0];
                    $miscStats[2] = $result->[1];
                    $miscStats[4] = $result->[2];
                    next;
                }
                #Third column is fumbles lost - other stuff doesn't matter
                elsif($i == 2) {
                    $miscStats[6] = $col->as_trimmed_text;
                }
                
                #Add any special teams TDs that were scored by players who had no other offensive stats
                my $counter = 0;
                foreach my $scoring (@scoring) {
                    my $scoring_txt = $scoring->parent->as_text;
            
                    #Skip Special Teams if records already exist when we enter.  That means we've already processed
                    #for this person in one of the other offensive areas.  Don't enter or we'll have too many special teams credits
                    next if($counter == 0 && exists $spTmTds->{$miscStats[1]});
                    
                    if ($scoring_txt =~ /$player_name makes \d+ yard kick return/) {
                        $spTmTds->{$miscStats[1]}++;
                    }
                    
                    if ($scoring_txt =~ /$player_name makes \d+ yard punt return/) {
                        $spTmTds->{$miscStats[1]}++;
                    }
                    
                    $counter++;
                }
                
                #Add any special teams TDs that were also scored by the player and then make sure we don't add it again.
                $miscStats[7] = $spTmTds->{$miscStats[1]} || "0";
                delete $spTmTds->{$miscStats[1]};
            }
            
            next if ($miscStats[6] eq "0" && $miscStats[7] eq "0");
            
            print $player_name;
            print Dumper(@miscStats);
            
            #Insert into the passing stats
            insert_row(q{
                insert into nfl_misc_stats
                    (statId, playerId, teamId, gameId, p_mnemonic, g_mnemonic, fl, spTmTD)
                    values
                    (?,?,?,?,?,?,?,?)
                },
                @miscStats
            );
        
        }
        
    }
    
    #Now that we've added the fumble stats, all that's left for misc is to add the SpecTmTds for players who didn't fumble
    foreach my $playerId (keys %{$spTmTds}) {
        
        my $result = fetchrow_array('SELECT teamId, mnemonic, firstName, lastName FROM nfl_player WHERE playerId=? order by dateCreated desc limit 1',$playerId);
        
        my @miscStats = ('1',$playerId,$result->[0],$gameId,$result->[1],$g_mnemonic,0,$spTmTds->{$playerId});
      
        print $result->[2]." ".$result->[3];
        print Dumper(@miscStats);
        
        insert_row(q{
            insert into nfl_misc_stats
                (statId, playerId, teamId, gameId, p_mnemonic, g_mnemonic, fl, spTmTD)
                values
                (?,?,?,?,?,?,?,?)
            },
            @miscStats
        );
    }
    
    #----------------------------------------------------------------------------------------------
    #                                       Defense
    #----------------------------------------------------------------------------------------------
    
    print "#---------------DEFENSE----------------------";
    
    #Clean up - Delete old defense data
    delete_row("delete from nfl_defense_stats where g_mnemonic=?",$g_mnemonic);
    
    #Get the teamIds
    $g_mnemonic =~ qr/NFL_\d+_(.+)/;
    print "Teams: $1";
    my @teams = split("@",$1);
    
    #Load team stats
    my $tstats = $tree->look_down(
        _tag  => q{div},
        class => q{gtTeamStats}
    );
    
    #Load the blocks
    my $blocks = getBlocks(\@teams,$g_mnemonic);
    
    my $counter = 1;
    
    foreach my $teamId (@teams) {
        my @defenseStats = ('1',$teamId,$gameId,$g_mnemonic,undef,0,undef,undef,undef,0,0,undef,undef);
        
        #Set current team and opponent locations (home or away) - this is used to scrape data
        my $teamLoc = "away";
        my $oppLoc  = "home";
        if($counter++ > 1) {
            $teamLoc = "home";
            $oppLoc = "away";
        }
        
        #Interceptions
        my $intreturns = $tstats->look_down(
            _tag => q{td},
            id => $teamLoc.q{-intreturns}
        )->as_trimmed_text;
        
        my ($ints,$returns) = split("-",$intreturns);
        $defenseStats[4] = $ints;
        
        #Defensive Fumble Recovery (DFR) - this is the opposite of fumbles lost so pick opponent stats
        my $fumbleslost = $tstats->look_down(
            _tag => q{td},
            id => $oppLoc.q{-fumbles}
        )->as_trimmed_text;
        
        my ($fumbles,$lost) = split("-",$fumbleslost);
        $defenseStats[8] = $lost;
        
        #Sacks - this is the opposite of times sacked lost so pick opponent stats
        my $sackedyards = $tstats->look_down(
            _tag => q{td},
            id => $oppLoc.q{-sacked}
        )->as_trimmed_text;
        
        my ($sacked,$yards) = split("-",$sackedyards);
        $defenseStats[7] = $sacked;
        
        #Safeties
        $defenseStats[6] = $tstats->look_down(
            _tag => q{td},
            id => $teamLoc.q{-safeties}
        )->as_trimmed_text;
        
        
        #Interceptions for TD, Fumble Return for TD, and Special Teams TDs
        my $opp_int_tds = 0;  #need your opponents INT TDs in order to calcluate points against.
        foreach my $scoring (@scoring) {
            my $scoring_img = $scoring->parent->parent->look_down( _tag => q{img} )->attr('src');
            $scoring_img =~ s/.*\/([^\/]*)$/$1/;
            my ($scoring_team,$junk) = split(/\./,$scoring_img);
            
            my $scoring_txt = $scoring->parent->as_text;
    
            
            #Int TDs - calulated for both team and their opponent.
            if ($scoring_txt =~ /\w+\s\w+ makes \d+ yard interception return/) {
                if($scoring_team eq $teamId) {
                    $defenseStats[5]++;
                }
                else {
                    $opp_int_tds++;
                }
            }
            
            
            #Skip these if the scoring team is not the current team, otherwise we duplicate the stats
            next unless $scoring_team eq $teamId;
            
            #Kick Return TD
            if ($scoring_txt =~ /\w+\s\w+ makes \d+ yard kick return/) {
               $defenseStats[10]++;
            }
           
            #Punt Return TD
            if ($scoring_txt =~ /\w+\s\w+ makes \d+ yard punt return/) {
               $defenseStats[10]++;
            }
            
            #Blocked Return TD
            if ($scoring_txt =~ /\w+\s\w+ makes \d+ yard blocked punt return/) {
               $defenseStats[10]++;
            }
            
            #Fumble Recovery TD
            if ($scoring_txt =~ /\w+\s\w+ makes \d+ yard fumble return/) {
               $defenseStats[9]++;
            }
           
        }
        
        
        #Points Allowed - this is the opponent's score
        $defenseStats[12] = $tree->look_down(
            _tag => q{div},
            class => qq{hud-team $oppLoc} 
        )->look_down(
            _tag => q{div},
            class => q{score}
        )->as_trimmed_text;
        
        #Int TDs allowed by offense not included in Points Allowed.  Remove from the points total
        $defenseStats[12] -= ($opp_int_tds * 6);
        
        #Blocks - Punts, XPs, and FGs
        $defenseStats[11] = $blocks->{$teamId};
        
        
        print $teamId;
        print Dumper(@defenseStats);
        
        insert_row(q{
            insert into nfl_defense_stats
                (statId, teamId, gameId, g_mnemonic, `int`, intTD, sfty, sack, dfr, dfrtd, spTmTD, blk, pa)
                values
                (?,?,?,?,?,?,?,?,?,?,?,?,?)
            },
            @defenseStats
        );
        
    }
    
    #----------------------------------------------------------------------------------------------
    #                                       Kickers
    #----------------------------------------------------------------------------------------------
    
    #Clean up - Delete old defense data
    delete_row("delete from nfl_kicker_stats where g_mnemonic=?",$g_mnemonic);
    
    
    #Load the rushing stats
    my @kickings = $tree->look_down(
        _tag  => q{span},
        class => qr/pStats04|pStats14/
    );
    
    print "#---------------KICKING----------------------";
    
    foreach my $kicking (@kickings) {
        
        my @rows = $kicking->look_down( _tag => q{tr} );
        #first row is column headers - get rid of it.
        shift @rows;
        
        foreach my $row (@rows) {
            
            my @kickingStats = ('1',undef,undef,$gameId,undef,$g_mnemonic,undef,undef,undef,0,0,0);
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
                    #Extract the playerId to see if we need to add the player or if we already have him
                    $link =~ /\/nfl\/players\/playerpage\/(\d+)\/.*/;
                    my $id = $1;
                    $result = fetchrow_array('SELECT playerId, teamId, mnemonic, firstName, lastName FROM nfl_player WHERE cbsPlayerUrl like ? order by dateCreated desc limit 1',"%".$id."%");
                    my $currTm = $result->[1];
                    if ( scalar(@{$result}) == 0 || $g_mnemonic !~ /$currTm/ ) {
                        print "Could not find player $link .  Adding to the database";
                        $result = updatePlayerProfile($link,$result);
                        
                        if( scalar(@{$result}) == 0 ) {
                            print "Could not add rushing stats for $link  Please try again";
                        }
                    }
                    
                    $player_name     = $result->[3]." ".$result->[4];
                    $kickingStats[1] = $result->[0];
                    
                    ##### - PROBLEM - IF PLAYER GETS TRADED TO ANOTHER TEAM DURING THE SEASON, NEED TO BE UPDATED
                    $kickingStats[2] = $result->[1];
                    $kickingStats[4] = $result->[2];
                    next;
                }
                #Second column is fg / att - only take the att here since FG doesn't include distance
                elsif ($i == 1) {
                    (my $junk,$kickingStats[8]) = split("/",$col->as_trimmed_text);
                }
                #Fourth Column is XP / att
                elsif($i == 3) {
                    ($kickingStats[7],$kickingStats[6]) = split("/",$col->as_trimmed_text);
                }
                
            }
            
            #Check for FGs
            foreach my $scoring (@scoring) {
                my $scoring_txt = $scoring->parent->as_text;
                if ($scoring_txt =~ /$player_name makes (\d+) yard kick/) {
                    my $distance = $1;
                    
                    if($distance < 40) {
                        $kickingStats[9]++;
                    }
                    elsif($distance < 50) {
                        $kickingStats[10]++;   
                    }
                    else {
                        $kickingStats[11]++;
                    }
                }
            }
            
            print $player_name;
            print Dumper(@kickingStats);
            
            #Insert into the passing stats
            insert_row(q{
                insert into nfl_kicker_stats
                    (statId, playerId, teamId, gameId, p_mnemonic, g_mnemonic, xpAtt, xp, fgAtt, `fg3pt`,`fg4pt`, `fg5pt`)
                    values
                    (?,?,?,?,?,?,?,?,?,?,?,?)
                },
                @kickingStats
            );
        
        }
    }

}


#----------------------------------------------------------------------------------------------
#                                       Methods
#----------------------------------------------------------------------------------------------


sub getBlocks {
    my $teams = shift;
    my $g_mnemonic = shift;
    
    #Get the Play by Play
    my $pbpPage = q{http://www.cbssports.com/nfl/gametracker/playbyplay/}.$g_mnemonic;
    
    #Get the play by play page
    my $pbpContent = get($pbpPage);
    my $pbpTree = HTML::Tree->new();
    $pbpTree->parse($pbpContent);
    
    #Load the Play by Play
    my @pbps = $pbpTree->look_down(
        _tag  => q{table},
        class    => q{data}
    )->look_down(
        _tag  => q{tr}
    );
    
    
    my $blocks = {
        $teams->[0] => 0,  #away team
        $teams->[1] => 0   #home team
    };
    
    my $curr_team = "";
    my $opp_team;
    foreach my $pbp (@pbps) {
        my $id = $pbp->attr('id');
        if($id eq "away") {
            $curr_team = $teams->[0];
            $opp_team = $teams->[1];
        }
        elsif($id eq "home") {
            $curr_team = $teams->[1];
            $opp_team = $teams->[0];
        }
        elsif($id eq "play" || $id eq "kick") {
            my $play_txt = $pbp->as_text;
            if($play_txt =~ qr/BLOCKED/i) {
                $blocks->{$opp_team}++;
            }
        }
        
    }
    
    return $blocks;

}

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


sub delete_row {
    insert_row(@_);
}

sub update_row {
    insert_row(@_);
}

sub insert_row {
    my $sql = shift;
    my @params = @_;
    
    my $sth = $dbh->prepare($sql);
    $sth->execute(@params);
    $sth->finish;
    
}


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

sub trim {
    my $str = shift;
    $str =~ s/^\s+|\s+$//g;
    return $str;
}

