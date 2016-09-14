#!/opt/local/bin/perl -l

BEGIN { push @INC, '/data/fantasyfootball/lib' }

use strict;

############################
#  Need to redo next year - switch to ESPN.  Code below updates existing table.  Needs to be rewritten to load
############################

use HTML::Tree;
use LWP::Simple;
use Data::Dumper;
use DBI;
use Getopt::Long;
use Date::Format;
use FF;
use FF::SQL;


my $remote = '';

GetOptions(
	'remote'   => \$remote
);

#Try to connect to the database
#LOCAL DB
my $dbi = q{dbi:mysql:database=ff2016;host=localhost};
my $user = "root";
my $pwd  = "nasty1";

#AMAZON DB
if($remote) {
    $dbi = q{dbi:mysql:database=scratch;host=127.0.0.1};
    $user = "frank";
    $pwd = "dri8kei";
    #$dbh = DBI->connect($dbi,'frank','dri8kei') or die "Connection Error: $DBI::errstr\n";
}

my $db = FF::SQL->connect($dbi,$user,$pwd) or die "Connection Error: $DBI::errstr\n";
my $ff = FF->new();


#my $dbh = DBI->connect($dbi,$user,$pwd) or die "Connection Error: $DBI::errstr\n";

#Get the CBS Page we want to retrieve
my $baseurl = q{http://www.espn.com/nfl/schedule/_/week/};


foreach (1..17) {
    my $week = $_;
    #Page is the cbs base page with 1 through 17 concatenated.
    my $page = $baseurl.$week;
    
    #Load the content
    my $content = get($page);
    my $tree = HTML::Tree->new();
    $tree->parse($content);
    
    #Clean up - Delete old data - will want to do this next year
    #delete_row("delete from nfl_schedule where week=?",$week);
    
    print "################################  Week $week    ###############";
    
    #Load the game data
    my @games = $tree->look_down(
        _tag  => q{tr},
        class => qr/odd|even/
    );
    
    foreach my $game (@games) {
        
        next if($game->attr('class') =~ /byeweek/);
        
        #Get the home team
        my $homeTeam = $ff->getAbbrv(
            $game->look_down(
                _tag  => q{td},
                class => q{home}
            )->look_down(
                _tag  => q{abbr}
            )->as_trimmed_text
        );
        
        #Get the espn gameId
        my $td   = ($game->look_down( _tag => q{td} ))[2];
        my $a    = $td->look_down( _tag => q{a} );
        my $link = $a->attr('href');
        $link =~ /\?gameId=(\d+)/;
        
        my $id = $1;
        
        #print qq{update nfl_schedule set id='$id' where week='$week' and homeTeamId='$homeTeam'};
        
        $db->update_row(
            q{update nfl_schedule set gameId=? where week=? and homeTeamId=?},
            $id, $week, $homeTeam
        );
        
        #Insert into the passing stats
        #insert_row(q{
        #        insert into nfl_schedule
        #        (gameId, week, season, mnemonic, homeTeamId, awayTeamId, gameTime)
        #        values
        #        (?,?,?,?,?,?,?)
        #    },
        #    @gameData
        #);
    
    }
    
}
