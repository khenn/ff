select
	name as 'Player',
	nds.teamId as 'Team',
	sum(`int`) as 'Int',
	sum(intTD) as 'IntTD',
	sum(sfty) as 'Sfty',
	sum(sack) as 'Sack',
	sum(dfr) as 'DFR',
	sum(dfrtd) as 'DFRTD',
	sum(SpTmTD) as 'SpTmTD',
	sum(Blk) as 'Blk',
	sum(PA) as 'PA',
    @payds := ( select sum(yrd) from nfl_passing_stats where (teamId in ( select homeTeamId from nfl_schedule where awayTeamId = nds.teamId ) or teamId in ( select awayTeamId from nfl_schedule where homeTeamId = nds.teamId )) and gameId in (select gameId from nfl_schedule where awayTeamId = nds.teamId or homeTeamId = nds.teamId) ) as 'PaYdA',
	@ruyds := ( select sum(yrd) from nfl_rushing_stats where (teamId in ( select homeTeamId from nfl_schedule where awayTeamId = nds.teamId ) or teamId in ( select awayTeamId from nfl_schedule where homeTeamId = nds.teamId )) and gameId in (select gameId from nfl_schedule where awayTeamId = nds.teamId or homeTeamId = nds.teamId) ) as 'RuYdA',
	ROUND((@payds + @ruyds),0) as 'TotYdsA',
	ROUND((  (sum(`int`) * 2) + ( sum(intTD) * 6) + ( sum(sfty) * 2) + (sum(sack) * 1) + (sum(dfr) * 2) + (sum(dfrtd) * 6) + (sum(SpTmTD) * 6) + (sum(Blk) * 2) +  (select SUM(IF(PA >= 35,-4,IF(PA >= 28,-1,IF(PA >= 21, 0, IF(PA >= 14, 1, IF(PA >= 7, 4, IF(PA >= 1,7,10))))))) as fpts from nfl_defense_stats nds1 where nds1.teamId=nds.teamId)  ),0) as 'FPTS'
from
	nfl_defense_stats nds
	join nfl_team nt on nds.teamId = nt.teamId
group by nds.teamId
order by FPTS desc





ROUND(( (   ,0) as 'FPTS'





select sum(yrd) from nfl_passing_stats where (teamId in ( select homeTeamId from nfl_schedule where awayTeamId = nds.teamId ) or teamId in ( select awayTeamId from nfl_schedule where homeTeamId = nds.teamId )) and gameId in (select gameId from nfl_schedule where awayTeamId = nds.teamId or homeTeamId = nds.teamId)
	
	
	
	
	
	select IF( homeTeamId = 'ARI',awayTeamId,homeTeamId) as 'Opp' 
		from (
			select gameId, homeTeamId, awayTeamId from nfl_schedule 
				where (homeTeamId = @teamId or awayTeamId = @teamId) and gameTime < NOW() 
			) as game_data ) and gameId in (select gameId from (select gameId, homeTeamId, awayTeamId from nfl_schedule where (homeTeamId = @teamId or awayTeamId = @teamId) and gameTime < NOW() ) as game_data)

