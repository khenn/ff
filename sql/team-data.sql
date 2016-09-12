select
	*
from(
select 
	nt.name as 'Player', 
	nt.teamId as 'Team',
	(select count(gameId) from nfl_schedule where (homeTeamId =  nt.teamId or awayTeamId = nt.teamId) and gameTime < NOW()) as 'Games Played',
	(select count(gameId) from nfl_schedule where ((homeTeamId =  nt.teamId and hScore > aScore) or (awayTeamId = nt.teamId and aScore > hScore)) and gameTime < NOW()) as 'Wins',
	(select count(gameId) from nfl_schedule where ((homeTeamId =  nt.teamId and hScore < aScore) or (awayTeamId = nt.teamId and aScore < hScore)) and gameTime < NOW()) as 'Loses',
	((select sum(hScore) from nfl_schedule where homeTeamId = nt.teamId) + (select sum(aScore) from nfl_schedule where awayTeamId = nt.teamId)) as 'PF',
	ROUND((((select sum(hScore) from nfl_schedule where homeTeamId = nt.teamId) + (select sum(aScore) from nfl_schedule where awayTeamId = nt.teamId)) / (select count(gameId) from nfl_schedule where (homeTeamId =  nt.teamId or awayTeamId = nt.teamId) and gameTime < NOW())),0) as 'Pts/Gm',
	(select sum(yrd) from nfl_passing_stats where teamId = nt.teamId) as 'PaYds',
	(select sum(yrd) from nfl_rushing_stats where teamId = nt.teamId) as 'RuYds',
	((select sum(yrd) from nfl_passing_stats where teamId = nt.teamId) + (select sum(yrd) from nfl_rushing_stats where teamId = nt.teamId)) as 'Total Yards'
from
	nfl_team nt
) as team_stats
order by `Total Yards` desc