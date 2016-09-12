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
my $week = undef;

GetOptions(
	'remote'   => \$remote,
	'week=s'   => \$week,
);

unless ( $week ) {
    print "Please tell me which weeks you want loaded using the --week=x flag";
    exit;
}

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
my $depth = load_week_data($week);

#-----------------------------   END GLOBAL VARIABLES ------------------------------ 

#Get the games for the current week
my $games = get_current_week($week);

foreach my $game (@$games) {
	my ($gameId, $week, $g_mnemonic, $homeTeam, $awayTeam) = @$game;
	
	print "################################   $g_mnemonic    ###############";    
	
	#Load the homeTeam Data
	#load_player_data($homeTeam, $gameId, $g_mnemonic, $week);
	
	#Load the awayTeam Data
	#load_player_data($awayTeam, $gameId, $g_mnemonic, $week);

	
}

#Load data

#Load the data into the database
print Dumper($depth);

#----------------------------------------------------------------------------------------------
#                                       Methods
#----------------------------------------------------------------------------------------------


#| gameId 0 | playerId 1 | g_mnemonic 2 | p_mnemonic 3 | week 4 | position 5 | Team 6 | dkfpts 7 |
#Load the week data
sub load_week_data {
	my ($week)  = @_;
	
	my $depth 	= {};
	
	my $teamCounter = {};
	my $playerData = fetchall_arrayref(sql_player_info(),$week);
	
	foreach my $player (@$playerData) {
		my $count = ++$teamCounter->{$player->[6]}->{$player->[5]};
		push(@{$depth->{$player->[6]}},{
			gameId 		=> $player->[0],
			playerId 	=> $player->[1],
			g_mnemonic  => $player->[2],
			p_mnemonic  => $player->[3],
			week		=> $player->[4],
			position    => $player->[5],
			depth       => $count
		});
	}
	
	return $depth;
	
}

sub get_current_week {
	my $week = shift;
	#Current week is all of the games for the week in which there are still games to play
	my $sql = q{select gameId, week, mnemonic, homeTeamId, awayTeamId from nfl_schedule where week = ?};
	return fetchall_arrayref($sql,$week);
}

#Loads variable data points for individual player for the week - Only care about depth.
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
			undef,
			undef,
			undef,
			undef,
			undef,
			undef
		);
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



sub sql_player_info {
	
	return q{
select 
	nfl_stats.gameId,
	nfl_stats.playerId,
	nfl_stats.g_mnemonic,
	nfl_stats.p_mnemonic,
	nfl_stats.week,
	nfl_stats.position,
	nfl_stats.Team,
	( (IFNULL(PaYd,0) * 0.04) + (IFNULL(PaTD,0) * 4) + (IFNULL(Pa2pt,0) * 2) + (IFNULL(PaInt,0) * -1) + (IFNULL(Pa300gm,0) * 3) + (IFNULL(RuYd,0) * 0.1) + (IFNULL(RuTD,0) * 6) + (IFNULL(Ru2pt,0) * 2) + (IFNULL(Ru100gm,0) * 3) + (IFNULL(ReRcpt,0) * 1) + (IFNULL(ReYd,0) * 0.1) + (IFNULL(ReTD,0) * 6) + (IFNULL(Re2pt,0) * 2) + (IFNULL(Re100gm,0) * 3) + (IFNULL(FL,0) * -1) * (IFNULL(SpTmTD,0) * 6) ) as 'dkfpts'
from (
select 
	np.playerId as 'playerId',
	np.cbsPlayerUrl as 'playerUrl',
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
	ns.gameId as 'gameId',
	ns.week as 'Week',
	nps.p_mnemonic,
	nps.g_mnemonic,
	nps.att as 'PaAtt',
	nps.cmp as 'PaCmp',
	nps.yrd as 'PaYd',
	nps.td as 'PaTD',
	nps.`2pt` as 'Pa2pt',
	nps.`int` as 'PaInt',
	nps.`300gm` as 'Pa300gm',
	nrs.att as 'RuAtt',
	nrs.yrd as 'RuYd',
	nrs.td as 'RuTD',
	nrs.`2pt` as 'Ru2pt',
	nrs.`100gm` as 'Ru100gm',
	nres.tgt as 'ReTgt',
	nres.recpt as 'ReRcpt',
	nres.yrd as 'ReYd',
	nres.td as 'ReTD',
	nres.`2pt` as 'Re2pt',
	nres.`100gm` as 'Re100gm',
	nms.fl as 'FL',
	nms.spTmTD as 'SpTmTD'
from 
	nfl_passing_stats nps
	join nfl_player np on nps.playerId=np.playerId
	join nfl_schedule ns on nps.gameId=ns.gameId
	left join nfl_rushing_stats nrs on nps.playerId=nrs.playerId and nps.gameId=nrs.gameId
	left join nfl_receiving_stats nres on nps.playerId=nres.playerId and nps.gameId=nres.gameId
	left join nfl_misc_stats nms on nps.playerId=nms.playerId and nps.gameId=nms.gameId
where
	np.position='QB' 
	or
	( np.position in ('RB','FB') and np.playerId not in (select distinct playerId from nfl_rushing_stats) )
	or
	( np.position in ('WR','TE') and np.playerId not in (select distinct playerId from nfl_receiving_stats) )
	or
	( np.position not in ('QB','RB','FB','WR','TE') )

UNION

select 
	np.playerId as 'playerId',
	np.cbsPlayerUrl as 'playerUrl',
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
	ns.gameId as 'gameId',
	ns.week as 'Week',
	nrs.p_mnemonic,
	nrs.g_mnemonic,
	nps.att as 'PaAtt',
	nps.cmp as 'PaCmp',
	nps.yrd as 'PaYd',
	nps.td as 'PaTD',
	nps.`2pt` as 'Pa2pt',
	nps.`int` as 'PaInt',
	nps.`300gm` as 'Pa300gm',
	nrs.att as 'RuAtt',
	nrs.yrd as 'RuYd',
	nrs.td as 'RuTD',
	nrs.`2pt` as 'Ru2pt',
	nrs.`100gm` as 'Ru100gm',
	nres.tgt as 'ReTgt',
	nres.recpt as 'ReRcpt',
	nres.yrd as 'ReYd',
	nres.td as 'ReTD',
	nres.`2pt` as 'Re2pt',
	nres.`100gm` as 'Re100gm',
	nms.fl as 'FL',
	nms.spTmTD as 'SpTmTD'
from 
	nfl_rushing_stats nrs
	join nfl_player np on nrs.playerId=np.playerId
	join nfl_schedule ns on nrs.gameId=ns.gameId
	left join nfl_passing_stats nps on nrs.playerId=nps.playerId and nrs.gameId=nps.gameId
	left join nfl_receiving_stats nres on nrs.playerId=nres.playerId and nrs.gameId=nres.gameId
	left join nfl_misc_stats nms on nrs.playerId=nms.playerId and nrs.gameId=nms.gameId
where
	(np.position in ('RB','FB')
	or
	( np.position in ('QB') and np.playerId not in (select distinct playerId from nfl_passing_stats) )
	or
	( np.position in ('WR','TE') and np.playerId not in (select distinct playerId from nfl_receiving_stats) )
	or
	( np.position not in ('QB','RB','FB','WR','TE') and np.playerId not in (select distinct playerId from nfl_passing_stats) ))

UNION

select 
	np.playerId as 'playerId',
	np.cbsPlayerUrl as 'playerUrl',
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
	ns.gameId as 'gameId',
	ns.week as 'Week',
	nres.p_mnemonic,
	nres.g_mnemonic,
	nps.att as 'PaAtt',
	nps.cmp as 'PaCmp',
	nps.yrd as 'PaYd',
	nps.td as 'PaTD',
	nps.`2pt` as 'Pa2pt',
	nps.`int` as 'PaInt',
	nps.`300gm` as 'Pa300gm',
	nrs.att as 'RuAtt',
	nrs.yrd as 'RuYd',
	nrs.td as 'RuTD',
	nrs.`2pt` as 'Ru2pt',
	nrs.`100gm` as 'Ru100gm',
	nres.tgt as 'ReTgt',
	nres.recpt as 'ReRcpt',
	nres.yrd as 'ReYd',
	nres.td as 'ReTD',
	nres.`2pt` as 'Re2pt',
	nres.`100gm` as 'Re100gm',
	nms.fl as 'FL',
	nms.spTmTD as 'SpTmTD'
from 
	nfl_receiving_stats nres
	join nfl_player np on nres.playerId=np.playerId
	join nfl_schedule ns on nres.gameId=ns.gameId
	left join nfl_passing_stats nps on nres.playerId=nps.playerId and nres.gameId=nps.gameId
	left join nfl_rushing_stats nrs on nres.playerId=nrs.playerId and nres.gameId=nrs.gameId
	left join nfl_misc_stats nms on nres.playerId=nms.playerId and nres.gameId=nms.gameId
where
	(np.position in ('WR')
	or
	( np.position in ('QB') and np.playerId not in (select distinct playerId from nfl_passing_stats) )
	or
	( np.position in ('RB','FB') and np.playerId not in (select distinct playerId from nfl_rushing_stats) )
	or
	( np.position not in ('QB','RB','FB','WR','TE') and np.playerId not in (select distinct playerId from nfl_passing_stats) and np.playerId not in (select distinct playerId from nfl_rushing_stats) )	)


UNION

select 
	np.playerId as 'playerId',
	np.cbsPlayerUrl as 'playerUrl',
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
	ns.gameId as 'gameId',
	ns.week as 'Week',
	nres.p_mnemonic,
	nres.g_mnemonic,
	nps.att as 'PaAtt',
	nps.cmp as 'PaCmp',
	nps.yrd as 'PaYd',
	nps.td as 'PaTD',
	nps.`2pt` as 'Pa2pt',
	nps.`int` as 'PaInt',
	nps.`300gm` as 'Pa300gm',
	nrs.att as 'RuAtt',
	nrs.yrd as 'RuYd',
	nrs.td as 'RuTD',
	nrs.`2pt` as 'Ru2pt',
	nrs.`100gm` as 'Ru100gm',
	nres.tgt as 'ReTgt',
	nres.recpt as 'ReRcpt',
	nres.yrd as 'ReYd',
	nres.td as 'ReTD',
	nres.`2pt` as 'Re2pt',
	nres.`100gm` as 'Re100gm',
	nms.fl as 'FL',
	nms.spTmTD as 'SpTmTD'
from 
	nfl_receiving_stats nres
	join nfl_player np on nres.playerId=np.playerId
	join nfl_schedule ns on nres.gameId=ns.gameId
	left join nfl_passing_stats nps on nres.playerId=nps.playerId and nres.gameId=nps.gameId
	left join nfl_rushing_stats nrs on nres.playerId=nrs.playerId and nres.gameId=nrs.gameId
	left join nfl_misc_stats nms on nres.playerId=nms.playerId and nres.gameId=nms.gameId
where
	(np.position in ('TE')
	or
	( np.position in ('QB') and np.playerId not in (select distinct playerId from nfl_passing_stats) )
	or
	( np.position in ('RB','FB') and np.playerId not in (select distinct playerId from nfl_rushing_stats) )
	or
	( np.position not in ('QB','RB','FB','WR','TE') and np.playerId not in (select distinct playerId from nfl_passing_stats) and np.playerId not in (select distinct playerId from nfl_rushing_stats) )	)

	
UNION
	
select 
	np.playerId as 'playerId',
	np.cbsPlayerUrl as 'playerUrl',
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
	ns.gameId as 'gameId',
	ns.week as 'Week',
	nres.p_mnemonic,
	nres.g_mnemonic,
	nps.att as 'PaAtt',
	nps.cmp as 'PaCmp',
	nps.yrd as 'PaYd',
	nps.td as 'PaTD',
	nps.`2pt` as 'Pa2pt',
	nps.`int` as 'PaInt',
	nps.`300gm` as 'Pa300gm',
	nrs.att as 'RuAtt',
	nrs.yrd as 'RuYd',
	nrs.td as 'RuTD',
	nrs.`2pt` as 'Ru2pt',
	nrs.`100gm` as 'Ru100gm',
	nres.tgt as 'ReTgt',
	nres.recpt as 'ReRcpt',
	nres.yrd as 'ReYd',
	nres.td as 'ReTD',
	nres.`2pt` as 'Re2pt',
	nres.`100gm` as 'Re100gm',
	nms.fl as 'FL',
	nms.spTmTD as 'SpTmTD'
from 
	nfl_misc_stats nms
	join nfl_player np on nms.playerId=np.playerId
	join nfl_schedule ns on nms.gameId=ns.gameId
	left join nfl_passing_stats nps on nms.playerId=nps.playerId and nms.gameId=nps.gameId
	left join nfl_rushing_stats nrs on nms.playerId=nrs.playerId and nms.gameId=nrs.gameId
	left join nfl_receiving_stats nres on nms.playerId=nres.playerId and nms.gameId=nres.gameId
where
	(( np.position in ('WR','TE')  and np.playerId not in (select distinct playerId from nfl_receiving_stats) )
	or
	( np.position in ('QB') and np.playerId not in (select distinct playerId from nfl_passing_stats) )
	or
	( np.position in ('RB','FB') and np.playerId not in (select distinct playerId from nfl_rushing_stats) )
	or
	( np.position not in ('QB','RB','FB','WR','TE') and np.playerId not in (select distinct playerId from nfl_passing_stats) and np.playerId not in (select distinct playerId from nfl_rushing_stats) and np.playerId not in (select distinct playerId from nfl_receiving_stats) )	)
) as nfl_stats
where week = ? and g_mnemonic is not null
order by g_mnemonic, team, position, dkfpts desc
};
}

