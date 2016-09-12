select
	passing_stats.*,
	( (PaYd * 0.04) + (PaTD * 4) + (PaINT * -1) + (Pa2P * 2) + (Pa300 * 3) + (IFNULL(RuYd,0) * 0.1) + (IFNULL(RuTd,0) * 6) + (IFNULL(Ru2pt,0) * 2) + (IFNULL(Ru100gm,0) * 3) + (IFNULL(FL,0) * -1) * (IFNULL(SpTmTD,0) * 6) ) as 'FPTS'
from (
select
	nfl_player.playerId,
	concat(firstName, ' ',lastName) as 'Player',
	nfl_stats.teamId as 'Team',
	sum(att) as 'PaAtt',
	sum(cmp) as 'PaCmp',
	sum(yrd) as 'PaYd',
	sum(td) as 'PaTD',
	sum(`int`) as 'PaINT',
	sum(`2pt`) as 'Pa2P',
	sum(`300gm`) as 'Pa300',
	sum(RuAtt) as 'RuAtt',
	sum(RuYrd) as 'RuYd',
	sum(RuTd) as 'RuTd',
	sum(Ru2pt) as 'Ru2pt',
	sum(Ru100gm) as 'Ru100gm',
	sum(fl) as 'FL',
	sum(spTmTD) as 'spTmTD'
from
	(select nps.*,nrs.att as 'RuAtt', nrs.yrd as 'RuYrd', nrs.td as 'RuTd',nrs.`2pt` as 'Ru2pt',nrs.`100gm` as 'Ru100gm',nms.fl as 'FL',nms.spTmTD as 'SpTmTd' from nfl_passing_stats nps left join nfl_rushing_stats nrs on nps.playerId=nrs.playerId and nps.gameId=nrs.gameId left join nfl_misc_stats nms on nps.playerId=nms.playerId and nps.gameId=nms.gameId) as nfl_stats	
	join nfl_player using (playerId)
where 
	position='QB'
group by playerId
) as passing_stats
order by FPTS desc