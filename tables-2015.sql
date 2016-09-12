DROP TABLE IF EXISTS nfl_team;
CREATE TABLE nfl_team (
	teamId char(3) not null,
	name varchar(40) not null,
	city varchar(40) not null,
	conf varchar(15) not null,
	division varchar(15) not null,
	primary key (teamId)
);

DELETE FROM nfl_team;

INSERT INTO nfl_team 
	(teamId, city, name, conf, division)
VALUES
	('NE','New England','Patriots','AFC','East'),
	('NYJ','New York', 'Jets', 'AFC','East'),
	('BUF','Buffalo', 'Bills', 'AFC', 'East'),
	('MIA','Miami','Dolphins','AFC','East'),
	('CIN','Cincinnati','Bengals','AFC','North'),
	('PIT','Pittsburgh','Steelers','AFC','North'),
	('CLE','Cleveland','Browns','AFC','North'),
	('BAL','Baltimore','Ravens','AFC','North'),
	('IND','Indianapolis','Colts','AFC','South'),
	('TEN','Tennessee','Titans','AFC','South'),
	('HOU','Houston','Texans','AFC','South'),
	('JAC','Jacksonville','Jaguars','AFC','South'),
	('DEN','Denver','Broncos','AFC','West'),
	('SD','San Diego','Chargers','AFC','West'),
	('OAK','Oakland','Raiders','AFC','West'),
	('KC','Kansas City','Chiefs','AFC','West'),
	('NYG','New York','Giants','NFC','East'),	
	('DAL','Dallas','Cowboys','NFC','East'),
	('PHI','Philadelphia','Eagles','NFC','East'),
	('WAS','Washington','Redskins','NFC','East'),
	('GB','Green Bay','Packers','NFC','North'),
	('MIN','Minnesota','Vikings','NFC','North'),
	('CHI','Chicago','Bears','NFC','North'),
	('DET','Detroit','Lions','NFC','North'),
	('ATL','Atlanta','Falcons','NFC','South'),
	('CAR','Carolina','Panthers','NFC','South'),
	('TB','Tampa Bay','Buccaneers','NFC','South'),
	('NO','New Orleans','Saints','NFC','South'),
	('AZ','Arizona','Cardinals','NFC','West'),
	('SEA','Seattle','Seahawks','NFC','West'),
	('STL','St Louis','Rams','NFC','West'),
	('SF','San Fransisco','49ers','NFC','West');

DROP TABLE IF EXISTS nfl_schedule;
CREATE TABLE nfl_schedule (
	gameId char(40) not null,
	week integer not null,
	season integer not null,
	mnemonic varchar(75) not null,
	homeTeamId char(3) not null,
	awayTeamId char(3) not null,
	hScore integer default 0,
	aScore integer default 0,
	gameTime datetime not null,
	primary key (gameId)
);

DELIMITER //
DROP TRIGGER IF EXISTS `nfl_schedule_GUID`;
CREATE TRIGGER `nfl_schedule_GUID` BEFORE INSERT ON `nfl_schedule`
 FOR EACH ROW begin
 SET new.gameId := (select md5(UUID()));
end //
DELIMITER ;

DELETE FROM nfl_schedule;
INSERT INTO nfl_schedule
	(gameId,week,season,mnemonic,awayTeamId,homeTeamId,aScore,hScore,gameTime)
VALUES
	('1',1,2015,'NFL_20150910_PIT@NE','PIT','NE',21,28,'2015-09-10 20:30:00'),
	('1',1,2015,'NFL_20150913_KC@HOU','KC','HOU',27,20,'2015-09-13 13:00:00'),
	('1',1,2015,'NFL_20150913_IND@BUF','IND','BUF',14,27,'2015-09-13 13:00:00'),
	('1',1,2015,'NFL_20150913_GB@CHI','GB','CHI',31,23,'2015-09-13 13:00:00'),
	('1',1,2015,'NFL_20150913_CAR@JAC','CAR','JAC',20,9,'2015-09-13 13:00:00'),
	('1',1,2015,'NFL_20150913_CLE@NYJ','CLE','NYJ',10,31,'2015-09-13 13:00:00'),
	('1',1,2015,'NFL_20150913_MIA@WAS','MIA','WAS',17,10,'2015-09-13 13:00:00'),
	('1',1,2015,'NFL_20150913_SEA@STL','SEA','STL',31,34,'2015-09-13 13:00:00'),
	('1',1,2015,'NFL_20150913_DET@SD','DET','SD',28,33,'2015-09-13 13:00:00'),
	('1',1,2015,'NFL_20150913_NO@ARI','NO','ARI',19,31,'2015-09-13 16:05:00'),
	('1',1,2015,'NFL_20150913_CIN@OAK','CIN','OAK',33,13,'2015-09-13 16:25:00'),
	('1',1,2015,'NFL_20150913_BAL@DEN','BAL','DEN',13,19,'2015-09-13 16:25:00'),
	('1',1,2015,'NFL_20150913_TEN@TB','TEN','TB',42,14,'2015-09-13 16:25:00'),
	('1',1,2015,'NFL_20150913_NYG@DAL','NYG','DAL',26,27,'2015-09-13 20:30:00'),
	('1',1,2015,'NFL_20150914_PHI@ATL','PHI','ATL',24,26,'2015-09-14 20:30:00'),
	('1',1,2015,'NFL_20150914_MIN@SF','MIN','SF',3,20,'2015-09-14 22:00:00'),
	('1',2,2015,'NFL_20150917_DEN@KC','DEN','KC',31,24,'2015-09-17 20:30:00'),
	('1',2,2015,'NFL_20150920_DET@MIN','DET','MIN',16,26,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_ARI@CHI','ARI','CHI',48,23,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_TEN@CLE','TEN','CLE',14,28,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_NE@BUF','NE','BUF',40,32,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_HOU@CAR','HOU','CAR',17,24,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_SF@PIT','SF','PIT',18,43,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_SD@CIN','SD','CIN',19,24,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_STL@WAS','STL','WAS',10,24,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_ATL@NYG','ATL','NYG',24,20,'2015-09-20 13:00:00'),
	('1',2,2015,'NFL_20150920_TB@NO','TB','NO',26,19,'2015-09-20 16:05:00'),
	('1',2,2015,'NFL_20150920_BAL@OAK','BAL','OAK',33,37,'2015-09-20 16:25:00'),
	('1',2,2015,'NFL_20150920_MIA@JAC','MIA','JAC',20,23,'2015-09-20 16:25:00'),
	('1',2,2015,'NFL_20150920_DAL@PHI','DAL','PHI',20,10,'2015-09-20 16:25:00'),
	('1',2,2015,'NFL_20150920_SEA@GB','SEA','GB',17,27,'2015-09-20 20:30:00'),
	('1',2,2015,'NFL_20150921_NYJ@IND','NYJ','IND',20,7,'2015-09-21 20:30:00'),
	('1',3,2015,'NFL_20150924_WAS@NYG','WAS','NYG',21,32,'2015-09-24 20:30:00'),
	('1',3,2015,'NFL_20150927_SD@MIN','SD','MIN',14,31,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_OAK@CLE','OAK','CLE',27,20,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_CIN@BAL','CIN','BAL',28,24,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_NO@CAR','NO','CAR',22,27,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_ATL@DAL','ATL','DAL',39,28,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_TB@HOU','TB','HOU',9,19,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_IND@TEN','IND','TEN',35,33,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_PIT@STL','PIT','STL',12,6,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_JAC@NE','JAC','NE',17,51,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_PHI@NYJ','PHI','NYJ',24,17,'2015-09-27 13:00:00'),
	('1',3,2015,'NFL_20150927_SF@ARI','SF','ARI',7,47,'2015-09-27 16:05:00'),
	('1',3,2015,'NFL_20150927_CHI@SEA','CHI','SEA',0,26,'2015-09-27 16:25:00'),
	('1',3,2015,'NFL_20150927_BUF@MIA','BUF','MIA',41,14,'2015-09-27 16:25:00'),
	('1',3,2015,'NFL_20150927_DEN@DET','DEN','DET',24,12,'2015-09-27 20:30:00'),
	('1',3,2015,'NFL_20150928_KC@GB','KC','GB',28,38,'2015-09-28 20:30:00'),
	('1',4,2015,'NFL_20151001_BAL@PIT','BAL','PIT',23,20,'2015-10-01 20:30:00'),
	('1',4,2015,'NFL_20151004_NYJ@MIA','NYJ','MIA',27,14,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_OAK@CHI','OAK','CHI',20,22,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_HOU@ATL','HOU','ATL',21,48,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_NYG@BUF','NYG','BUF',24,10,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_JAC@IND','JAC','IND',13,16,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_KC@CIN','KC','CIN',21,36,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_PHI@WAS','PHI','WAS',20,23,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_CAR@TB','CAR','TB',37,23,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_CLE@SD','CLE','SD',27,30,'2015-10-04 13:00:00'),
	('1',4,2015,'NFL_20151004_GB@SF','GB','SF',17,3,'2015-10-04 16:05:00'),
	('1',4,2015,'NFL_20151004_STL@ARI','STL','ARI',24,22,'2015-10-04 16:25:00'),
	('1',4,2015,'NFL_20151004_MIN@DEN','MIN','DEN',20,23,'2015-10-04 16:25:00'),
	('1',4,2015,'NFL_20151004_DAL@NO','DAL','NO',20,26,'2015-10-04 20:30:00'),
	('1',4,2015,'NFL_20151005_DET@SEA','DET','SEA',10,13,'2015-10-05 20:30:00'),
	('1',5,2015,'NFL_20151008_IND@HOU','IND','HOU',27,20,'2015-10-08 20:30:00'),
	('1',5,2015,'NFL_20151011_CLE@BAL','CLE','BAL',33,30,'2015-10-11 13:00:00'),
	('1',5,2015,'NFL_20151011_STL@GB','STL','GB',10,24,'2015-10-11 13:00:00'),
	('1',5,2015,'NFL_20151011_BUF@TEN','BUF','TEN',14,13,'2015-10-11 13:00:00'),
	('1',5,2015,'NFL_20151011_NO@PHI','NO','PHI',17,39,'2015-10-11 13:00:00'),
	('1',5,2015,'NFL_20151011_WAS@ATL','WAS','ATL',19,25,'2015-10-11 13:00:00'),
	('1',5,2015,'NFL_20151011_SEA@CIN','SEA','CIN',24,27,'2015-10-11 13:00:00'),
	('1',5,2015,'NFL_20151011_CHI@KC','CHI','KC',18,17,'2015-10-11 13:00:00'),
	('1',5,2015,'NFL_20151011_JAC@TB','JAC','TB',31,38,'2015-10-11 13:00:00'),
	('1',5,2015,'NFL_20151011_ARI@DET','ARI','DET',42,17,'2015-10-11 16:05:00'),
	('1',5,2015,'NFL_20151011_NE@DAL','NE','DAL',30,6,'2015-10-11 16:25:00'),
	('1',5,2015,'NFL_20151011_DEN@OAK','DEN','OAK',16,10,'2015-10-11 16:25:00'),
	('1',5,2015,'NFL_20151011_SF@NYG','SF','NYG',27,30,'2015-10-11 16:25:00'),
	('1',5,2015,'NFL_20151012_PIT@SD','PIT','SD',24,20,'2015-10-12 20:30:00'),
	('1',6,2015,'NFL_20151015_ATL@NO','ATL','NO',0,0,'2015-10-15 20:25:00'),
	('1',6,2015,'NFL_20151018_DEN@CLE','DEN','DLE',0,0,'2015-10-18 13:00:00'),
	('1',6,2015,'NFL_20151018_CHI@DET','CHI','DET',0,0,'2015-10-18 13:00:00'),
	('1',6,2015,'NFL_20151018_HOU@JAC','HOU','JAC',0,0,'2015-10-18 13:00:00'),
	('1',6,2015,'NFL_20151018_CIN@BUF','CIN','BUF',0,0,'2015-10-18 13:00:00'),
	('1',6,2015,'NFL_20151018_WAS@NYJ','WAS','NYJ',0,0,'2015-10-18 13:00:00'),
	('1',6,2015,'NFL_20151018_KC@MIN','KC','MIN',0,0,'2015-10-18 13:00:00'),
	('1',6,2015,'NFL_20151018_ARI@PIT','ARI','PIT',0,0,'2015-10-18 13:00:00'),
	('1',6,2015,'NFL_20151018_MIA@TEN','MIA','TEN',0,0,'2015-10-18 13:00:00'),
	('1',6,2015,'NFL_20151018_CAR@SEA','CAR','SEA',0,0,'2015-10-18 16:05:00'),
	('1',6,2015,'NFL_20151018_BAL@SF','BAL','SF',0,0,'2015-10-18 16:25:00'),
	('1',6,2015,'NFL_20151018_SD@GB','SD','GB',0,0,'2015-10-18 16:25:00'),
	('1',6,2015,'NFL_20151018_NE@IND','NE','IND',0,0,'2015-10-18 20:30:00'),
	('1',6,2015,'NFL_20151019_NYG@PHI','NYG','PHI',0,0,'2015-10-19 20:30:00'),
	('1',7,2015,'NFL_20151022_SEA@SF','SEA','SF',0,0,'2015-10-22 20:25:00'),
	('1',7,2015,'NFL_20151025_BUF@JAC','BUF','JAC',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_PIT@KC','PIT','KC',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_HOU@MIA','HOU','MIA',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_ATL@TEN','ATL','TEN',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_CLE@STL','CLE','STL',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_TB@WAS','TB','WAS',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_MIN@DET','MIN','DET',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_NO@IND','NO','IND',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_NYJ@NE','NYJ','NE',0,0,'2015-10-25 13:00:00'),
	('1',7,2015,'NFL_20151025_OAK@SD','OAK','SD',0,0,'2015-10-25 16:05:00'),
	('1',7,2015,'NFL_20151025_DAL@NYG','DAL','NYG',0,0,'2015-10-25 16:25:00'),
	('1',7,2015,'NFL_20151025_PHI@CAR','PHI','CAR',0,0,'2015-10-25 20:30:00'),
	('1',7,2015,'NFL_20151026_BAL@ARI','BAL','ARI',0,0,'2015-10-26 20:30:00'),
	('1',8,2015,'NFL_20151029_MIA@NE','MIA','NE',0,0,'2015-10-29 20:25:00'),
	('1',8,2015,'NFL_20151101_DET@KC','DET','KC',0,0,'2015-11-01 08:30:00'),
	('1',8,2015,'NFL_20151101_MIN@CHI','MIN','CHI',0,0,'2015-11-01 13:00:00'),
	('1',8,2015,'NFL_20151101_ARI@CLE','ARI','CLE',0,0,'2015-11-01 13:00:00'),
	('1',8,2015,'NFL_20151101_SD@BAL','SD','BAL',0,0,'2015-11-01 13:00:00'),
	('1',8,2015,'NFL_20151101_TB@ATL','TB','ATL',0,0,'2015-11-01 13:00:00'),
	('1',8,2015,'NFL_20151101_NYG@NO','NYG','NO',0,0,'2015-11-01 13:00:00'),
	('1',8,2015,'NFL_20151101_TEN@HOU','TEN','HOU',0,0,'2015-11-01 13:00:00'),
	('1',8,2015,'NFL_20151101_CIN@PIT','CIN','PIT',0,0,'2015-11-01 13:00:00'),
	('1',8,2015,'NFL_20151101_SF@STL','SF','STL',0,0,'2015-11-01 13:00:00'),
	('1',8,2015,'NFL_20151101_NYJ@OAK','NYJ','OAK',0,0,'2015-11-01 16:25:00'),
	('1',8,2015,'NFL_20151101_SEA@DAL','SEA','DAL',0,0,'2015-11-01 16:25:00'),
	('1',8,2015,'NFL_20151101_GB@DEN','GB','DEN',0,0,'2015-11-01 20:30:00'),
	('1',8,2015,'NFL_20151102_IND@CAR','IND','CAR',0,0,'2015-11-02 20:30:00'),
	('1',9,2015,'NFL_20151105_CLE@CIN','CLE','CIN',0,0,'2015-11-05 20:30:00'),
	('1',9,2015,'NFL_20151108_OAK@PIT','OAK','PIT',0,0,'2015-11-08 13:00:00'),
	('1',9,2015,'NFL_20151108_GB@CAR','GB','CAR',0,0,'2015-11-08 13:00:00'),
	('1',9,2015,'NFL_20151108_WAS@NE','WAS','NE',0,0,'2015-11-08 13:00:00'),
	('1',9,2015,'NFL_20151108_TEN@NO','TEN','NO',0,0,'2015-11-08 13:00:00'),
	('1',9,2015,'NFL_20151108_JAC@NYJ','JAC','NYJ',0,0,'2015-11-08 13:00:00'),
	('1',9,2015,'NFL_20151108_STL@MIN','STL','MIN',0,0,'2015-11-08 13:00:00'),
	('1',9,2015,'NFL_20151108_MIA@BUF','MIA','BUF',0,0,'2015-11-08 13:00:00'),
	('1',9,2015,'NFL_20151108_ATL@SF','ATL','SF',0,0,'2015-11-08 16:05:00'),
	('1',9,2015,'NFL_20151108_NYG@TB','NYG','TB',0,0,'2015-11-08 16:05:00'),
	('1',9,2015,'NFL_20151108_DEN@IND','DEN','IND',0,0,'2015-11-08 16:25:00'),
	('1',9,2015,'NFL_20151108_PHI@DAL','PHI','DAL',0,0,'2015-11-08 20:30:00'),
	('1',9,2015,'NFL_20151109_CHI@SD','CHI','SD',0,0,'2015-11-09 20:30:00'),
	('1',10,2015,'NFL_20151112_BUF@NYJ','BUF','NYJ',0,0,'2015-11-12 20:25:00'),
	('1',10,2015,'NFL_20151115_DET@GB','DET','GB',0,0,'2015-11-15 13:00:00'),
	('1',10,2015,'NFL_20151115_JAC@BAL','JAC','BAL',0,0,'2015-11-15 13:00:00'),
	('1',10,2015,'NFL_20151115_CHI@STL','CHI','STL',0,0,'2015-11-15 13:00:00'),
	('1',10,2015,'NFL_20151115_CLE@PIT','CLE','PIT',0,0,'2015-11-15 13:00:00'),
	('1',10,2015,'NFL_20151115_CAR@TEN','CAR','TEN',0,0,'2015-11-15 13:00:00'),
	('1',10,2015,'NFL_20151115_NO@WAS','NO','WAS',0,0,'2015-11-15 13:00:00'),
	('1',10,2015,'NFL_20151115_DAL@TB','DAL','TB',0,0,'2015-11-15 13:00:00'),
	('1',10,2015,'NFL_20151115_MIA@PHI','MIA','PHI',0,0,'2015-11-15 13:00:00'),
	('1',10,2015,'NFL_20151115_MIN@OAK','MIN','OAK',0,0,'2015-11-15 16:05:00'),
	('1',10,2015,'NFL_20151115_KC@DEN','KC','DEN',0,0,'2015-11-15 16:25:00'),
	('1',10,2015,'NFL_20151115_NE@NYG','NE','NYG',0,0,'2015-11-15 16:25:00'),
	('1',10,2015,'NFL_20151115_ARI@SEA','ARI','SEA',0,0,'2015-11-15 20:30:00'),
	('1',10,2015,'NFL_20151116_HOU@CIN','HOU','CIN',0,0,'2015-11-16 20:30:00'),
	('1',11,2015,'NFL_20151119_TEN@JAC','TEN','JAC',0,0,'2015-11-19 20:25:00'),
	('1',11,2015,'NFL_20151122_STL@BAL','STL','BAL',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_WAS@CAR','WAS','CAR',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_DEN@CHI','DEN','CHI',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_OAK@DET','OAK','DET',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_GB@MIN','GB','MIN',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_IND@ATL','IND','ATL',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_DAL@MIA','DAL','MIA',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_TB@PHI','TB','PHI',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_NYJ@HOU','NYJ','HOU',0,0,'2015-11-22 13:00:00'),
	('1',11,2015,'NFL_20151122_CIN@ARI','CIN','ARI',0,0,'2015-11-22 16:05:00'),
	('1',11,2015,'NFL_20151122_SF@SEA','SF','SEA',0,0,'2015-11-22 16:25:00'),
	('1',11,2015,'NFL_20151122_KC@SD','KC','SD',0,0,'2015-11-22 20:30:00'),
	('1',11,2015,'NFL_20151123_BUF@NE','BUF','NE',0,0,'2015-11-23 20:30:00'),
	('1',12,2015,'NFL_20151126_PHI@DET','PHI','DET',0,0,'2015-11-26 20:30:00'),
	('1',12,2015,'NFL_20151126_CAR@DAL','CAR','DAL',0,0,'2015-11-26 20:30:00'),
	('1',12,2015,'NFL_20151126_CHI@GB','CHI','GB',0,0,'2015-11-26 20:30:00'),
	('1',12,2015,'NFL_20151129_NO@HOU','NO','HOU',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_BUF@KC','BUF','KC',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_SD@JAC','SD','JAC',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_MIN@ATL','MIN','ATL',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_MIA@NYJ','MIA','NYJ',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_NYG@WAS','NYG','WAS',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_OAK@TEN','OAK','TEN',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_STL@CIN','STL','CIN',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_TB@IND','TB','IND',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_ARI@SF','ARI','SF',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_PIT@SEA','PIT','SEA',0,0,'2015-11-29 13:00:00'),
	('1',12,2015,'NFL_20151129_NE@DEN','NE','DEN',0,0,'2015-11-29 20:30:00'),
	('1',12,2015,'NFL_20151130_BAL@CLE','BAL','CLE',0,0,'2015-11-30 20:30:00'),
	('1',13,2015,'NFL_20151203_GB@DET','GB','DET',0,0,'2015-12-03 20:30:00'),
	('1',13,2015,'NFL_20151206_SEA@MIN','SEA','MIN',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_CIN@CLE','CIN','CLE',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_BAL@MIA','BAL','MIA',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_HOU@BUF','HOU','BUF',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_SF@CHI','SF','CHI',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_JAC@TEN','JAC','TEN',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_ATL@TB','ATL','TB',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_ARI@STL','ARI','STL',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_NYJ@NYG','NYJ','NYG',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_CAR@NO','CAR','NO',0,0,'2015-12-06 13:00:00'),
	('1',13,2015,'NFL_20151206_DEN@SD','DEN','SD',0,0,'2015-12-06 16:05:00'),
	('1',13,2015,'NFL_20151206_KC@OAK','KC','OAK',0,0,'2015-12-06 16:05:00'),
	('1',13,2015,'NFL_20151206_PHI@NE','PHI','NE',0,0,'2015-12-06 16:20:00'),
	('1',13,2015,'NFL_20151206_IND@PIT','IND','PIT',0,0,'2015-12-06 20:30:00'),
	('1',13,2015,'NFL_20151207_DAL@WAS','DAL','WAS',0,0,'2015-12-06 20:30:00'),
	('1',14,2015,'NFL_20151210_MIN@ARI','MIN','ARI',0,0,'2015-12-10 20:30:00'),
	('1',14,2015,'NFL_20151213_ATL@CAR','ATL','CAR',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_BUF@PHI','BUF','PHI',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_NE@HOU','NE','HOU',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_PIT@CIN','PIT','CIN',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_WAS@CHI','WAS','CHI',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_SF@CLE','SF','CLE',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_IND@JAC','IND','JAC',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_SD@KC','SD','KC',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_TEN@NYJ','TEN','NYJ',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_DET@STL','DET','STL',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_NO@TB','NO','TB',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_OAK@DEN','OAK','DEN',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_DAL@GB','DAL','GB',0,0,'2015-12-13 13:00:00'),
	('1',14,2015,'NFL_20151213_SEA@BAL','SEA','BAL',0,0,'2015-12-13 20:30:00'),
	('1',14,2015,'NFL_20151214_NYG@MIA','NYG','MIA',0,0,'2015-12-14 20:30:00'),
	('1',15,2015,'NFL_20151217_TB@STL','TB','STL',0,0,'2015-12-17 20:25:00'),
	('1',15,2015,'NFL_20151219_NYJ@DAL','NYJ','DAL',0,0,'2015-12-19 20:25:00'),
	('1',15,2015,'NFL_20151220_CAR@NYG','CAR','NYG',0,0,'2015-12-20 13:00:00'),
	('1',15,2015,'NFL_20151220_TEN@NE','TEN','NE',0,0,'2015-12-20 13:00:00'),
	('1',15,2015,'NFL_20151220_KC@BAL','KC','BAL',0,0,'2015-12-20 13:00:00'),
	('1',15,2015,'NFL_20151220_ATL@JAC','ATL','JAC',0,0,'2015-12-20 13:00:00'),
	('1',15,2015,'NFL_20151220_CHI@MIN','CHI','MIN',0,0,'2015-12-20 13:00:00'),
	('1',15,2015,'NFL_20151220_HOU@IND','HOU','IND',0,0,'2015-12-20 13:00:00'),
	('1',15,2015,'NFL_20151220_ARI@PHI','ARI','PHI',0,0,'2015-12-20 13:00:00'),
	('1',15,2015,'NFL_20151220_BUF@WAS','BUF','WAS',0,0,'2015-12-20 13:00:00'),
	('1',15,2015,'NFL_20151220_CLE@SEA','CLE','SEA',0,0,'2015-12-20 16:05:00'),
	('1',15,2015,'NFL_20151220_GB@OAK','GB','OAK',0,0,'2015-12-20 16:05:00'),
	('1',15,2015,'NFL_20151220_DEN@PIT','DEN','PIT',0,0,'2015-12-20 16:25:00'),
	('1',15,2015,'NFL_20151220_MIA@SD','MIA','SD',0,0,'2015-12-20 16:25:00'),
	('1',15,2015,'NFL_20151220_CIN@SF','CIN','SF',0,0,'2015-12-20 20:30:00'),
	('1',15,2015,'NFL_20151220_DET@NO','DET','NO',0,0,'2015-12-21 20:30:00'),
	('1',16,2015,'NFL_20151224_SD@OAK','SD','OAK',0,0,'2015-12-24 20:25:00'),
	('1',16,2015,'NFL_20151226_WAS@PHI','WAS','PHI',0,0,'2015-12-26 20:25:00'),
	('1',16,2015,'NFL_20151227_SF@DET','SF','DET',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_CLE@KC','CLE','KC',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_HOU@TEN','HOU','TEN',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_JAC@NO','JAC','NO',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_NE@NYJ','NE','NYJ',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_CAR@ATL','CAR','ATL',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_CHI@TB','CHI','TB',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_DAL@BUF','DAL','BUF',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_NYG@MIN','NYG','MIN',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_IND@MIA','IND','MIA',0,0,'2015-12-27 13:00:00'),
	('1',16,2015,'NFL_20151227_STL@SEA','STL','SEA',0,0,'2015-12-27 16:25:00'),
	('1',16,2015,'NFL_20151227_GB@ARI','GB','ARI',0,0,'2015-12-27 16:25:00'),
	('1',16,2015,'NFL_20151227_PIT@BAL','PIT','BAL',0,0,'2015-12-27 20:30:00'),
	('1',16,2015,'NFL_20151228_CIN@DEN','CIN','DEN',0,0,'2015-12-28 20:30:00'),
	('1',17,2015,'NFL_20160103_NO@ATL','NO','ATL',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_NYJ@BUF','NYJ','BUF',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_WAS@DAL','WAS','DAL',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_TEN@IND','TEN','IND',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_TB@CAR','TB','CAR',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_DET@CHI','DET','CHI',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_PIT@CLE','PIT','CLE',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_MIN@GB','MIN','GB',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_OAK@KC','OAK','KC',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_NE@MIA','NE','MIA',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_PHI@NYG','PHI','NYG',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_BAL@CIN','BAL','CIN',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_JAC@HOU','JAC','HOU',0,0,'2016-01-03 13:00:00'),
	('1',17,2015,'NFL_20160103_SEA@ARI','SEA','ARI',0,0,'2016-01-03 16:25:00'),
	('1',17,2015,'NFL_20160103_SD@DEN','SD','DEN',0,0,'2016-01-03 16:25:00'),
	('1',17,2015,'NFL_20160103_STL@SF','STL','SF',0,0,'2016-01-03 16:25:00');
	

DROP TABLE IF EXISTS nfl_player;
CREATE TABLE nfl_player (
	playerId char(40) not null,
	teamId char(3) not null,
	firstName varchar(20) not null,
	lastname varchar(50) not null,
	mnemonic varchar(75) not null,
	position char(3) not null,
	status char(3) not null,
	cbsPlayerUrl varchar(100),
	photoUrl varchar(2083),
	primary key (playerId)
);

DELIMITER //
DROP TRIGGER IF EXISTS `nfl_player_GUID`;
CREATE TRIGGER `nfl_player_GUID` BEFORE INSERT ON `nfl_player`
 FOR EACH ROW begin
 SET new.playerId := (select md5(UUID()));
end //
DELIMITER ;

DROP TABLE IF EXISTS nfl_passing_stats;
CREATE TABLE nfl_passing_stats (
	statId char(40) not null,
	playerId char(40) not null,
	teamId char(40) not null,
	gameId char(40) not null,
	p_mnemonic varchar(75) not null,
	g_mnemonic varchar(75) not null,
	att integer not null default 0,
	cmp integer not null default 0,
	yrd integer not null default 0,
	td integer not null default 0,
	`int` integer not null default 0,
	`2pt` integer not null default 0,
	`300gm` tinyint(1) not null default 0,
	primary key (statId)
);

DELIMITER //
DROP TRIGGER IF EXISTS `nfl_passing_stats_GUID`;
CREATE TRIGGER `nfl_passing_stats_GUID` BEFORE INSERT ON `nfl_passing_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end //
DELIMITER ;


DROP TABLE IF EXISTS nfl_rushing_stats;
CREATE TABLE nfl_rushing_stats (
	statId char(40) not null,
	playerId char(40) not null,
	teamId char(40) not null,
	gameId char(40) not null,
	p_mnemonic varchar(75) not null,
	g_mnemonic varchar(75) not null,
	att integer not null default 0,
	yrd integer not null default 0,
	td integer not null default 0,
	`2pt` integer not null default 0,
	`100gm` tinyint(1) not null default 0,
	primary key (statId)
);

DELIMITER //
DROP TRIGGER IF EXISTS `nfl_rushing_stats_GUID`;
CREATE TRIGGER `nfl_rushing_stats_GUID` BEFORE INSERT ON `nfl_rushing_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end //
DELIMITER ;


DROP TABLE IF EXISTS nfl_receiving_stats;
CREATE TABLE nfl_receiving_stats (
	statId char(40) not null,
	playerId char(40) not null,
	teamId char(40) not null,
	gameId char(40) not null,
	p_mnemonic varchar(75) not null,
	g_mnemonic varchar(75) not null,
	tgt integer not null default 0,
	recpt integer not null default 0,
	yrd integer not null default 0,
	td integer not null default 0,
	`2pt` integer not null default 0,
	`100gm` tinyint(1) not null default 0,
	primary key (statId)
);

DELIMITER //
DROP TRIGGER IF EXISTS `nfl_receiving_stats_GUID`;
CREATE TRIGGER `nfl_receiving_stats_GUID` BEFORE INSERT ON `nfl_receiving_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end //
DELIMITER ;

DROP TABLE IF EXISTS nfl_misc_stats;
CREATE TABLE nfl_misc_stats (
	statId char(40) not null,
	playerId char(40) not null,
	teamId char(40) not null,
	gameId char(40) not null,
	p_mnemonic varchar(75) not null,
	g_mnemonic varchar(75) not null,
	fl integer not null default 0,
	spTmTD integer not null default 0,
	primary key (statId)
);

DELIMITER //
DROP TRIGGER IF EXISTS `nfl_misc_stats_GUID`;
CREATE TRIGGER `nfl_misc_stats_GUID` BEFORE INSERT ON `nfl_misc_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end //
DELIMITER ;


DROP TABLE IF EXISTS nfl_defense_stats;
CREATE TABLE nfl_defense_stats (
	statId char(40) not null,
	teamId char(40) not null,
	gameId char(40) not null,
	g_mnemonic varchar(75) not null,
	`int` integer not null default 0,
	intTD integer not null default 0,
	sfty integer not null default 0,
	sack integer not null default 0,
	dfr integer not null default 0,
	dfrtd integer not null default 0,
	spTmTD integer not null default 0,
	blk integer not null default 0,
	pa integer not null default 0,
	primary key (statId)
);

DELIMITER //
DROP TRIGGER IF EXISTS `nfl_defense_stats_GUID`;
CREATE TRIGGER `nfl_defense_stats_GUID` BEFORE INSERT ON `nfl_defense_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end //
DELIMITER ;

DROP TABLE IF EXISTS nfl_kicker_stats;
CREATE TABLE nfl_kicker_stats (
	statId char(40) not null,
	playerId char(40) not null,
	teamId char(40) not null,
	gameId char(40) not null,
	p_mnemonic varchar(75) not null,
	g_mnemonic varchar(75) not null,
	xpAtt integer not null default 0,
	xp integer not null default 0,
	fgAtt integer not null default 0,
	`fg3pt` integer not null default 0,
	`fg4pt` integer not null default 0,
	`fg5pt` integer not null default 0,
	primary key (statId)
);

DELIMITER //
DROP TRIGGER IF EXISTS `nfl_kicker_stats_GUID`;
CREATE TRIGGER `nfl_kicker_stats_GUID` BEFORE INSERT ON `nfl_kicker_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end //
DELIMITER ;





