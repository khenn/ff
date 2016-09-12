select
	receiving_stats.*,
	( (IFNULL(RuYd,0) * 0.1) + (IFNULL(RuTd,0) * 6) + (IFNULL(Ru2pt,0) * 2) + (IFNULL(Ru100gm,0) * 3) + (IFNULL(ReRecpt,0) * 1) + (IFNULL(ReYd,0) * 0.1) + (IFNULL(ReTd,0) * 6) + (IFNULL(Re2pt,0) * 2) + (IFNULL(Re100gm,0) * 3) + (IFNULL(FL,0) * -1) * (IFNULL(SpTmTD,0) * 6) ) as 'FPTS'
from (
select
	concat(firstName, ' ',lastName) as 'Player',
	nfl_stats.teamId as 'Team',
	sum(tgt) as 'ReTgt',
	sum(recpt) as 'ReRecpt',
	sum(yrd) as 'ReYd',
	sum(td) as 'ReTD',
	sum(`2pt`) as 'Re2pt',
	sum(`100gm`) as 'Re100gm',
	sum(RuAtt) as 'RuAtt',
	sum(RuYd) as 'RuYd',
	sum(RuTd) as 'RuTd',
	sum(`Ru2pt`) as 'Ru2pt',
	sum(`Ru100gm`) as 'Ru100gm',
	sum(fl) as 'FL',
	sum(spTmTD) as 'spTmTD'
from
	(select nres.*, nrs.att as 'RuAtt', nrs.yrd as 'RuYd', nrs.td as 'RuTd',nrs.`2pt` as 'Ru2pt',nrs.`100gm` as 'Ru100gm',nms.fl as 'FL',nms.spTmTD as 'SpTmTd' from nfl_receiving_stats nres left join nfl_rushing_stats nrs on nres.playerId=nrs.playerId and nres.gameId=nrs.gameId left join nfl_misc_stats nms on nres.playerId=nms.playerId and nres.gameId=nms.gameId) as nfl_stats	
	join nfl_player using (playerId)
where 
	position='WR'
group by playerId
) as receiving_stats
order by FPTS desc