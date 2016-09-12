select 
	concat(np.firstName,' ',np.lastName) as 'Player Name',
	np.position as 'Position',
	np.teamId as 'Team',
	IF(np.teamId = ns.homeTeamId, ns.awayTeamId, ns.homeTeamId) as 'Opp',
	ns.week as 'Week',
	nks.p_mnemonic,
	nks.g_mnemonic,
	nks.xpAtt as 'xpAtt',
	nks.xp as 'xp',
	nks.fgAtt as 'fgAtt',
	(nks.fg3pt + nks.fg4pt + nks.fg5pt) as 'fg',
	nks.fg3pt as 'fg3pt',
	nks.fg4pt as 'fg4pt',
	nks.fg5pt as 'fg5pt'
from 
	nfl_kicker_stats nks
	join nfl_player np on nks.playerId=np.playerId
	join nfl_schedule ns on nks.gameId=ns.gameId
where
	week < 8
order by np.teamId, ns.week
