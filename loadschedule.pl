#!/opt/local/bin/perl -l
use strict;

use HTML::Tree;
use LWP::Simple;
use Data::Dumper;
use DBI;
use Getopt::Long;
use Date::Format;

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

my $dbh = DBI->connect($dbi,$user,$pwd) or die "Connection Error: $DBI::errstr\n";

#Get the CBS Page we want to retrieve
my $cbsbase = q{http://www.cbssports.com/nfl/schedules/regular/2016/week};


foreach (1..17) {
    my $week = $_;
    #Page is the cbs base page with 1 through 17 concatenated.
    my $page = $cbsbase.$week;
    
    #Load the content
    my $content = get($page);
    my $tree = HTML::Tree->new();
    $tree->parse($content);
    
    #Clean up - Delete old data
    delete_row("delete from nfl_schedule where week=?",$week);
    
    print "################################  Week $week    ###############";
    
    #Load the game data
    my @games = $tree->look_down(
        _tag  => q{tr},
        class => qr/row1|row2/
    );
    
    foreach my $game (@games) {
    
        #Get the td with all the data in it
        my $td       = ($game->look_down( _tag => q{td} ))[1];
        #Get the link
        my $a        = $td->look_down( _tag=>q{a});
        #Link has info we need, parse it
        my $link     = $a->attr('href');
        
        my $span     = $a->look_down( _tag => q{span} );
        
        my $time     = "1473381000";
        if( $span ) {
            $time     = $span->attr('data-gmt');
        }
        
        $link        =~ /\/nfl\/gametracker\/NFL_(\d+)_(\w+)@(\w+)/;
        my $mnemonic = "NFL_$1_$2".'@'.$3;
        
        
        #http://www.cbssports.com//nfl/gametracker/NFL_20160908_CAR@DEN
        my @gameData = ();
        push @gameData, '1', $week, '2016',$mnemonic,$3,$2,time2str('%Y-%m-%d %X',($time+3600));
        
        print Dumper(@gameData);
    
        #Insert into the passing stats
        insert_row(q{
                insert into nfl_schedule
                (gameId, week, season, mnemonic, homeTeamId, awayTeamId, gameTime)
                values
                (?,?,?,?,?,?,?)
            },
            @gameData
        );
    
    }
    
}



#----------------------------------------------------------------------------------------------
#                                       Methods
#----------------------------------------------------------------------------------------------

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

sub trim {
    my $str = shift;
    $str =~ s/^\s+|\s+$//g;
    return $str;
}

