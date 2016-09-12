#!/opt/local/bin/perl -l
use strict;

use HTML::Tree;
use LWP::Simple;
use Data::Dumper;
use DBI;
use JSON;
use Tie::IxHash;
use List::Util qw(sum);
use Math::Round;
use Statistics::Basic qw(:all);
use Getopt::Long;

my $remote = '';

GetOptions(
	'remote'   => \$remote
);

#----------------------------------------------------------------------------------------------
#   This script is dynamic.  If a new line is added to the page, it will be skipped
#   To add the line, update the database and add two new columns
#
#   h_[name-of-betting-location]_line
#   h_[name-of-betting-location]_ou
#
#   Where [name-of-betting-location] is the class name used by the site to describe the column
#   That this line happens to be in.  You can find it on http://www.oddsshard.com/nfl/odds by searching for
#   "op-item op-spread op-" on the page code.
#   You will find a different css class name for each location.
#
#   Examples:
#   Mirage will be found as "op-item op-spread op-mirage" and should be in the database as h_mirage_line and h_mirage_ou
#   SportBet will be found as "op-item op-spread op-sportbet" and should be in the database as h_sportbet_line and h_sportbet_ou
#   NEW will be found as "op-item op-spread op-NEW" and should be added in the database as h_NEW_line and h_NEW_ou
#
#   Once the script can find NEW in the database, it will automatically start to import the data
#
#----------------------------------------------------------------------------------------------


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

my $dbh = DBI->connect($dbi,$user,$pwd) or die "Connection Error: $DBI::errstr\n";

#Try to connect to the database

my $json = JSON->new->allow_nonref;

#Get the page
my $page = q{http://www.oddsshark.com/nfl/odds};

#Load the content
my $content = get($page);
my $tree = HTML::Tree->new();
$tree->parse($content);


#Build an array containing all of the columns - we'll use this to determine whether or not the line currently exists or has been added - precautionary.
my $columns = fetchall_arrayref(q{SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`=? AND `TABLE_NAME`='nfl_vegas'},$schema);
my $colset = [];
foreach my $col (@$columns) {
    push @$colset, $col->[0];
}

    
#Get the games
my @games = $tree->look_down(
    _tag  => q{div},
    id    => q{op-content-wrapper}
)->look_down(
    _tag  => q{div},
    class => q{op-matchup-wrapper football}
);

my $g = [];
foreach my $game (@games) {
    #Look up the game
    my $awayStr = $game->look_down(
        _tag  => q{div},
        class => q{op-matchup-team op-matchup-text op-team-top}
    )->attr('data-op-name');
    
    my $homeStr = $game->look_down(
        _tag  => q{div},
        class => q{op-matchup-team op-matchup-text op-team-bottom}
    )->attr('data-op-name');
    

    my $homeRef = $json->decode( $homeStr );
    my $awayRef = $json->decode( $awayStr );
    
    my $home = $homeRef->{short_name};
    my $away = $awayRef->{short_name};
    
    my $result = fetchrow_array('SELECT gameId, mnemonic FROM nfl_schedule WHERE homeTeamId=? and awayTeamId=? order by gameTime desc limit 1',$home,$away);
    
    #Store the gameID    
    tie my %h, 'Tie::IxHash', (
        gameId          => $result->[0],
        g_mnemonic      => $result->[1],
        h_avg_line      => [],
        h_avg_ou        => [],
        h_median_line   => 0,
        h_median_ou     => 0,
        h_high_line     => 0,
        h_low_line      => 0,
        h_high_ou       => 0,
        h_low_ou        => 0
    );
    push(@{$g},\%h);
}
    
    
my @lous = $tree->look_down(
    _tag  => q{div},
    id    => q{op-results}
)->look_down(
    _tag  => q{div},
    class => q{op-item-row-wrapper not-futures}
);

my $counter = 0;
    
foreach my $lou (@lous) {
    
    my $game = $g->[$counter++];
        
    my @divs = $lou->content_list();
    
    my $index = 0;
    foreach my $div (@divs) {
        my @data = $div->content_list();
        my $hdata = $data[2];
        
        #Get the sportbetting line name (bovada, mirage, etc)
        my $class = $hdata->attr('class');
        my $loc   = "";
        if($class =~ /op-item op-spread op-(.*)/i) {
            $loc = $1;
            #Trim off trailing words like .lv for bovida.lv - don't want these in the database as columns
            ($loc,my $junk) = split(/\./,$loc);
        }
        
        #If the line name is not in the database, skip it
        my $dbLineName = q{h_}.$loc.q{_line};
        unless(/$dbLineName/ ~~ @{$colset}) {
            print "Couldn't find $dbLineName ... skipping";
            next;
        }
        
        #If the ou name is not in the database, skip it
        my $dbOUName = q{h_}.$loc.q{_ou};
        unless(/$dbOUName/ ~~ @{$colset}) {
            print "Couldn't find $dbOUName ... skipping";
            next;
        }
        
        my $lineRef = $json->decode( $hdata->attr('data-op-info') );
        my $ouRef   = $json->decode( $hdata->attr('data-op-total') );
        $game->{$dbLineName} = $lineRef->{fullgame} eq 'Ev' ? 0 : $lineRef->{fullgame} + 0;
        $game->{$dbOUName} = $ouRef->{fullgame} eq 'Ev' ? 0 : $ouRef->{fullgame} + 0;
        
        
        push(@{$game->{h_avg_line}},$game->{$dbLineName}) if ($dbLineName !~ /opening/ && $game->{$dbLineName} != 0);
        push(@{$game->{h_avg_ou}},$game->{$dbOUName}) if ($dbOUName !~ /opening/ && $game->{$dbOUName} != 0);
        
        $index++;
    }
    
    #Sort the averages
    @{$game->{h_avg_line}} = sort{$b <=> $a} @{$game->{h_avg_line}};
    @{$game->{h_avg_ou}} = sort{$b <=> $a} @{$game->{h_avg_ou}};
    
    
    #Compute the median
    $game->{h_median_line} = median(@{$game->{h_avg_line}}) + 0;
    $game->{h_median_ou} = median(@{$game->{h_avg_ou}}) + 0;
    
    #Remove the first and last elements of both line and ou.
    $game->{h_high_line} = shift(@{$game->{h_avg_line}}) || 0;
    $game->{h_low_line} = pop(@{$game->{h_avg_line}}) || 0;
    $game->{h_high_ou} = shift(@{$game->{h_avg_ou}}) || 0;
    $game->{h_low_ou} = pop(@{$game->{h_avg_ou}}) || 0;
    
    #Compute the average - drops off the first and last elements in the array
    $game->{h_avg_line} = avg(@{$game->{h_avg_line}});
    $game->{h_avg_ou} =  avg(@{$game->{h_avg_ou}});

}

#Replace data into the database

foreach my $game (@$g) {
    
    my @data    = values %$game;
    my @binding = map { '?' } @data;
    
    my $sql = q{replace into nfl_vegas (}.join(",",keys %$game).q{) values (}.join(",",@binding).q{)};
    
    print "updating game ".$data[1];
    
    replace_row($sql,@data);
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

sub replace_row {
    my $sql = shift;
    my @params = @_;
    
    my $sth = $dbh->prepare($sql);
    $sth->execute(@params);
    $sth->finish;
    
}

sub avg {
    my $scalar = @_;
    
    return 0 if ($scalar == 0);
    
    my $avg = sum(@_)/@_;
    
    #Double the average, then round to the nearest integer, then divide by 2
    return (round($avg*2))/2;
}
