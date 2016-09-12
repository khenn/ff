select 
	nfl_stats.`Player Name`,
	nfl_stats.Team,
	nfl_stats.Position,
	( (IFNULL(PaYd,0) * 0.04) + (IFNULL(PaTD,0) * 4) + (IFNULL(Pa2pt,0) * 2) + (IFNULL(PaInt,0) * -1) + (IFNULL(Pa300gm,0) * 3) + (IFNULL(RuYd,0) * 0.1) + (IFNULL(RuTD,0) * 6) + (IFNULL(Ru2pt,0) * 2) + (IFNULL(Ru100gm,0) * 3) + (IFNULL(ReRcpt,0) * 1) + (IFNULL(ReYd,0) * 0.1) + (IFNULL(ReTD,0) * 6) + (IFNULL(Re2pt,0) * 2) + (IFNULL(Re100gm,0) * 3) + (IFNULL(FL,0) * -1) * (IFNULL(SpTmTD,0) * 6) ) as 'DKFPTS'
from (
select 
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	npgi.`depth` as 'Depth',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
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
	nms.spTmTD as 'SpTmTD',
	npgi.injuryStatus as 'InjStatus',
	npgi.injuryDetail as 'InjDetail',
	npgi.injuryNotes as 'InjNotes'
from 
	nfl_passing_stats nps
	join nfl_player np on nps.playerId=np.playerId
	join nfl_schedule ns on nps.gameId=ns.gameId
	left join nfl_rushing_stats nrs on nps.playerId=nrs.playerId and nps.gameId=nrs.gameId
	left join nfl_receiving_stats nres on nps.playerId=nres.playerId and nps.gameId=nres.gameId
	left join nfl_misc_stats nms on nps.playerId=nms.playerId and nps.gameId=nms.gameId
	left join nfl_player_game_info npgi on nps.playerId=npgi.playerId and nps.gameId=npgi.gameId
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
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	npgi.`depth` as 'Depth',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
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
	nms.spTmTD as 'SpTmTD',
	npgi.injuryStatus as 'InjStatus',
	npgi.injuryDetail as 'InjDetail',
	npgi.injuryNotes as 'InjNotes'
from 
	nfl_rushing_stats nrs
	join nfl_player np on nrs.playerId=np.playerId
	join nfl_schedule ns on nrs.gameId=ns.gameId
	left join nfl_passing_stats nps on nrs.playerId=nps.playerId and nrs.gameId=nps.gameId
	left join nfl_receiving_stats nres on nrs.playerId=nres.playerId and nrs.gameId=nres.gameId
	left join nfl_misc_stats nms on nrs.playerId=nms.playerId and nrs.gameId=nms.gameId
	left join nfl_player_game_info npgi on nrs.playerId=npgi.playerId and nrs.gameId=npgi.gameId
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
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	npgi.`depth` as 'Depth',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
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
	nms.spTmTD as 'SpTmTD',
	npgi.injuryStatus as 'InjStatus',
	npgi.injuryDetail as 'InjDetail',
	npgi.injuryNotes as 'InjNotes'
from 
	nfl_receiving_stats nres
	join nfl_player np on nres.playerId=np.playerId
	join nfl_schedule ns on nres.gameId=ns.gameId
	left join nfl_passing_stats nps on nres.playerId=nps.playerId and nres.gameId=nps.gameId
	left join nfl_rushing_stats nrs on nres.playerId=nrs.playerId and nres.gameId=nrs.gameId
	left join nfl_misc_stats nms on nres.playerId=nms.playerId and nres.gameId=nms.gameId
	left join nfl_player_game_info npgi on nres.playerId=npgi.playerId and nres.gameId=npgi.gameId
where
	(np.position in ('WR','TE')
	or
	( np.position in ('QB') and np.playerId not in (select distinct playerId from nfl_passing_stats) )
	or
	( np.position in ('RB','FB') and np.playerId not in (select distinct playerId from nfl_rushing_stats) )
	or
	( np.position not in ('QB','RB','FB','WR','TE') and np.playerId not in (select distinct playerId from nfl_passing_stats) and np.playerId not in (select distinct playerId from nfl_rushing_stats) )	)
	
UNION
	
select 
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	npgi.`depth` as 'Depth',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
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
	nms.spTmTD as 'SpTmTD',
	npgi.injuryStatus as 'InjStatus',
	npgi.injuryDetail as 'InjDetail',
	npgi.injuryNotes as 'InjNotes'
from 
	nfl_misc_stats nms
	join nfl_player np on nms.playerId=np.playerId
	join nfl_schedule ns on nms.gameId=ns.gameId
	left join nfl_passing_stats nps on nms.playerId=nps.playerId and nms.gameId=nps.gameId
	left join nfl_rushing_stats nrs on nms.playerId=nrs.playerId and nms.gameId=nrs.gameId
	left join nfl_receiving_stats nres on nms.playerId=nres.playerId and nms.gameId=nres.gameId
	left join nfl_player_game_info npgi on nms.playerId=npgi.playerId and nms.gameId=npgi.gameId
where
	(( np.position in ('WR','TE')  and np.playerId not in (select distinct playerId from nfl_receiving_stats) )
	or
	( np.position in ('QB') and np.playerId not in (select distinct playerId from nfl_passing_stats) )
	or
	( np.position in ('RB','FB') and np.playerId not in (select distinct playerId from nfl_rushing_stats) )
	or
	( np.position not in ('QB','RB','FB','WR','TE') and np.playerId not in (select distinct playerId from nfl_passing_stats) and np.playerId not in (select distinct playerId from nfl_rushing_stats) and np.playerId not in (select distinct playerId from nfl_receiving_stats) )	)
) as nfl_stats
group by p_mnemonic
order by week desc, dkfpts desc