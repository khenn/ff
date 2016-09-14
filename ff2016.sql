-- MySQL dump 10.13  Distrib 5.6.27, for osx10.8 (x86_64)
--
-- Host: localhost    Database: ff2016
-- ------------------------------------------------------
-- Server version	5.6.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `nfl_defense_stats`
--

DROP TABLE IF EXISTS `nfl_defense_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_defense_stats` (
  `statId` char(40) NOT NULL,
  `teamId` char(40) NOT NULL,
  `gameId` char(40) NOT NULL,
  `g_mnemonic` varchar(75) NOT NULL,
  `int` int(11) NOT NULL DEFAULT '0',
  `intTD` int(11) NOT NULL DEFAULT '0',
  `sfty` int(11) NOT NULL DEFAULT '0',
  `sack` int(11) NOT NULL DEFAULT '0',
  `dfr` int(11) NOT NULL DEFAULT '0',
  `dfrtd` int(11) NOT NULL DEFAULT '0',
  `spTmTD` int(11) NOT NULL DEFAULT '0',
  `blk` int(11) NOT NULL DEFAULT '0',
  `pa` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_defense_stats`
--

LOCK TABLES `nfl_defense_stats` WRITE;
/*!40000 ALTER TABLE `nfl_defense_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_defense_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nfl_defense_stats_GUID` BEFORE INSERT ON `nfl_defense_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nfl_kicker_stats`
--

DROP TABLE IF EXISTS `nfl_kicker_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_kicker_stats` (
  `statId` char(40) NOT NULL,
  `playerId` char(40) NOT NULL,
  `teamId` char(40) NOT NULL,
  `gameId` char(40) NOT NULL,
  `p_mnemonic` varchar(75) NOT NULL,
  `g_mnemonic` varchar(75) NOT NULL,
  `xpAtt` int(11) NOT NULL DEFAULT '0',
  `xp` int(11) NOT NULL DEFAULT '0',
  `fgAtt` int(11) NOT NULL DEFAULT '0',
  `fg3pt` int(11) NOT NULL DEFAULT '0',
  `fg4pt` int(11) NOT NULL DEFAULT '0',
  `fg5pt` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_kicker_stats`
--

LOCK TABLES `nfl_kicker_stats` WRITE;
/*!40000 ALTER TABLE `nfl_kicker_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_kicker_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nfl_kicker_stats_GUID` BEFORE INSERT ON `nfl_kicker_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nfl_misc_stats`
--

DROP TABLE IF EXISTS `nfl_misc_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_misc_stats` (
  `statId` char(40) NOT NULL,
  `playerId` char(40) NOT NULL,
  `teamId` char(40) NOT NULL,
  `gameId` char(40) NOT NULL,
  `p_mnemonic` varchar(75) NOT NULL,
  `g_mnemonic` varchar(75) NOT NULL,
  `fl` int(11) NOT NULL DEFAULT '0',
  `spTmTD` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_misc_stats`
--

LOCK TABLES `nfl_misc_stats` WRITE;
/*!40000 ALTER TABLE `nfl_misc_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_misc_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nfl_misc_stats_GUID` BEFORE INSERT ON `nfl_misc_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nfl_passing_stats`
--

DROP TABLE IF EXISTS `nfl_passing_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_passing_stats` (
  `statId` char(40) NOT NULL,
  `playerId` char(40) NOT NULL,
  `teamId` char(40) NOT NULL,
  `gameId` char(40) NOT NULL,
  `p_mnemonic` varchar(75) NOT NULL,
  `g_mnemonic` varchar(75) NOT NULL,
  `att` int(11) NOT NULL DEFAULT '0',
  `cmp` int(11) NOT NULL DEFAULT '0',
  `yrd` int(11) NOT NULL DEFAULT '0',
  `td` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `2pt` int(11) NOT NULL DEFAULT '0',
  `300gm` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_passing_stats`
--

LOCK TABLES `nfl_passing_stats` WRITE;
/*!40000 ALTER TABLE `nfl_passing_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_passing_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nfl_passing_stats_GUID` BEFORE INSERT ON `nfl_passing_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nfl_player`
--

DROP TABLE IF EXISTS `nfl_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_player` (
  `playerId` char(40) NOT NULL,
  `teamId` char(3) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `mnemonic` varchar(75) NOT NULL,
  `position` char(3) NOT NULL,
  `status` char(3) NOT NULL,
  `cbsPlayerUrl` varchar(100) DEFAULT NULL,
  `photoUrl` varchar(2083) DEFAULT NULL,
  `dateCreated` date DEFAULT NULL,
  PRIMARY KEY (`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_player`
--

LOCK TABLES `nfl_player` WRITE;
/*!40000 ALTER TABLE `nfl_player` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_player` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nfl_player_GUID` BEFORE INSERT ON `nfl_player`
 FOR EACH ROW begin
 SET new.playerId := (select md5(UUID()));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nfl_player_game_info`
--

DROP TABLE IF EXISTS `nfl_player_game_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_player_game_info` (
  `gameId` char(40) NOT NULL,
  `playerId` char(40) NOT NULL,
  `g_mnemonic` varchar(75) NOT NULL,
  `p_mnemonic` varchar(75) NOT NULL,
  `week` int(11) NOT NULL,
  `position` char(4) NOT NULL,
  `depth` int(11) DEFAULT NULL,
  `injuryStatus` char(4) DEFAULT NULL,
  `injuryDetail` varchar(255) DEFAULT NULL,
  `injuryNotes` varchar(2000) DEFAULT NULL,
  `DKsalary` int(11) DEFAULT NULL,
  `FDsalary` int(11) DEFAULT NULL,
  `YHsalary` int(11) DEFAULT NULL,
  PRIMARY KEY (`gameId`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_player_game_info`
--

LOCK TABLES `nfl_player_game_info` WRITE;
/*!40000 ALTER TABLE `nfl_player_game_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_player_game_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nfl_receiving_stats`
--

DROP TABLE IF EXISTS `nfl_receiving_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_receiving_stats` (
  `statId` char(40) NOT NULL,
  `playerId` char(40) NOT NULL,
  `teamId` char(40) NOT NULL,
  `gameId` char(40) NOT NULL,
  `p_mnemonic` varchar(75) NOT NULL,
  `g_mnemonic` varchar(75) NOT NULL,
  `tgt` int(11) NOT NULL DEFAULT '0',
  `recpt` int(11) NOT NULL DEFAULT '0',
  `yrd` int(11) NOT NULL DEFAULT '0',
  `td` int(11) NOT NULL DEFAULT '0',
  `2pt` int(11) NOT NULL DEFAULT '0',
  `100gm` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_receiving_stats`
--

LOCK TABLES `nfl_receiving_stats` WRITE;
/*!40000 ALTER TABLE `nfl_receiving_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_receiving_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nfl_receiving_stats_GUID` BEFORE INSERT ON `nfl_receiving_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nfl_rushing_stats`
--

DROP TABLE IF EXISTS `nfl_rushing_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_rushing_stats` (
  `statId` char(40) NOT NULL,
  `playerId` char(40) NOT NULL,
  `teamId` char(40) NOT NULL,
  `gameId` char(40) NOT NULL,
  `p_mnemonic` varchar(75) NOT NULL,
  `g_mnemonic` varchar(75) NOT NULL,
  `att` int(11) NOT NULL DEFAULT '0',
  `yrd` int(11) NOT NULL DEFAULT '0',
  `td` int(11) NOT NULL DEFAULT '0',
  `2pt` int(11) NOT NULL DEFAULT '0',
  `100gm` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_rushing_stats`
--

LOCK TABLES `nfl_rushing_stats` WRITE;
/*!40000 ALTER TABLE `nfl_rushing_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_rushing_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nfl_rushing_stats_GUID` BEFORE INSERT ON `nfl_rushing_stats`
 FOR EACH ROW begin
 SET new.statId := (select md5(UUID()));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nfl_schedule`
--

DROP TABLE IF EXISTS `nfl_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_schedule` (
  `gameId` char(40) NOT NULL,
  `week` int(11) NOT NULL,
  `season` int(11) NOT NULL,
  `mnemonic` varchar(75) NOT NULL,
  `homeTeamId` char(3) NOT NULL,
  `awayTeamId` char(3) NOT NULL,
  `hScore` int(11) DEFAULT '0',
  `aScore` int(11) DEFAULT '0',
  `gameTime` datetime NOT NULL,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_schedule`
--

LOCK TABLES `nfl_schedule` WRITE;
/*!40000 ALTER TABLE `nfl_schedule` DISABLE KEYS */;
INSERT INTO `nfl_schedule` VALUES ('400874428',14,2016,'NFL_20161208_OAK@KC','KC','OAK',0,0,'2016-12-08 20:25:00'),('400874429',7,2016,'NFL_20161020_CHI@GB','GB','CHI',0,0,'2016-10-20 20:25:00'),('400874483',5,2016,'NFL_20161006_ARI@SF','SF','ARI',0,0,'2016-10-06 20:25:00'),('400874484',1,2016,'NFL_20160908_CAR@DEN','DEN','CAR',0,0,'2016-09-08 20:30:00'),('400874485',16,2016,'NFL_20161222_NYG@PHI','PHI','NYG',0,0,'2016-12-22 20:25:00'),('400874486',1,2016,'NFL_20160911_GB@JAC','JAC','GB',0,0,'2016-09-11 13:00:00'),('400874487',2,2016,'NFL_20160918_CIN@PIT','PIT','CIN',0,0,'2016-09-18 13:00:00'),('400874488',2,2016,'NFL_20160918_TEN@DET','DET','TEN',0,0,'2016-09-18 13:00:00'),('400874489',16,2016,'NFL_20161224_MIA@BUF','BUF','MIA',0,0,'2016-12-24 13:00:00'),('400874490',7,2016,'NFL_20161023_NYG@LAR','LAR','NYG',0,0,'2016-10-23 09:30:00'),('400874491',7,2016,'NFL_20161023_NO@KC','KC','NO',0,0,'2016-10-23 13:00:00'),('400874492',7,2016,'NFL_20161023_IND@TEN','TEN','IND',0,0,'2016-10-23 13:00:00'),('400874493',7,2016,'NFL_20161023_MIN@PHI','PHI','MIN',0,0,'2016-10-23 13:00:00'),('400874494',7,2016,'NFL_20161023_CLE@CIN','CIN','CLE',0,0,'2016-10-23 13:00:00'),('400874495',12,2016,'NFL_20161124_MIN@DET','DET','MIN',0,0,'2016-11-24 12:30:00'),('400874496',7,2016,'NFL_20161023_WAS@DET','DET','WAS',0,0,'2016-10-23 13:00:00'),('400874497',14,2016,'NFL_20161211_PIT@BUF','BUF','PIT',0,0,'2016-12-11 13:00:00'),('400874498',7,2016,'NFL_20161023_OAK@JAC','JAC','OAK',0,0,'2016-10-23 13:00:00'),('400874499',12,2016,'NFL_20161124_WAS@DAL','DAL','WAS',0,0,'2016-11-24 16:30:00'),('400874500',7,2016,'NFL_20161023_BUF@MIA','MIA','BUF',0,0,'2016-10-23 13:00:00'),('400874501',7,2016,'NFL_20161023_BAL@NYJ','NYJ','BAL',0,0,'2016-10-23 13:00:00'),('400874502',12,2016,'NFL_20161124_PIT@IND','IND','PIT',0,0,'2016-11-24 20:30:00'),('400874503',7,2016,'NFL_20161023_TB@SF','SF','TB',0,0,'2016-10-23 16:05:00'),('400874504',14,2016,'NFL_20161211_DEN@TEN','TEN','DEN',0,0,'2016-12-11 13:00:00'),('400874505',7,2016,'NFL_20161023_SD@ATL','ATL','SD',0,0,'2016-10-23 16:05:00'),('400874506',7,2016,'NFL_20161023_NE@PIT','PIT','NE',0,0,'2016-10-23 16:25:00'),('400874507',12,2016,'NFL_20161127_TEN@CHI','CHI','TEN',0,0,'2016-11-27 13:00:00'),('400874508',7,2016,'NFL_20161023_SEA@ARI','ARI','SEA',0,0,'2016-10-23 20:30:00'),('400874509',7,2016,'NFL_20161024_HOU@DEN','DEN','HOU',0,0,'2016-10-24 20:30:00'),('400874510',1,2016,'NFL_20160911_BUF@BAL','BAL','BUF',0,0,'2016-09-11 13:00:00'),('400874511',1,2016,'NFL_20160911_CHI@HOU','HOU','CHI',0,0,'2016-09-11 13:00:00'),('400874512',2,2016,'NFL_20160918_BAL@CLE','CLE','BAL',0,0,'2016-09-18 13:00:00'),('400874513',16,2016,'NFL_20161224_TB@NO','NO','TB',0,0,'2016-12-24 13:00:00'),('400874514',2,2016,'NFL_20160918_SEA@LAR','LAR','SEA',0,0,'2016-09-18 16:05:00'),('400874515',2,2016,'NFL_20160918_TB@ARI','ARI','TB',0,0,'2016-09-18 16:05:00'),('400874516',16,2016,'NFL_20161224_NYJ@NE','NE','NYJ',0,0,'2016-12-24 13:00:00'),('400874517',2,2016,'NFL_20160918_JAC@SD','SD','JAC',0,0,'2016-09-18 16:25:00'),('400874518',2,2016,'NFL_20160918_DAL@WAS','WAS','DAL',0,0,'2016-09-18 13:00:00'),('400874519',5,2016,'NFL_20161009_NE@CLE','CLE','NE',0,0,'2016-10-09 13:00:00'),('400874520',1,2016,'NFL_20160911_CLE@PHI','PHI','CLE',0,0,'2016-09-11 13:00:00'),('400874521',16,2016,'NFL_20161224_TEN@JAC','JAC','TEN',0,0,'2016-12-24 13:00:00'),('400874522',1,2016,'NFL_20160911_TB@ATL','ATL','TB',0,0,'2016-09-11 13:00:00'),('400874523',16,2016,'NFL_20161224_MIN@GB','GB','MIN',0,0,'2016-12-24 13:00:00'),('400874524',1,2016,'NFL_20160911_MIN@TEN','TEN','MIN',0,0,'2016-09-11 13:00:00'),('400874525',2,2016,'NFL_20160918_ATL@OAK','OAK','ATL',0,0,'2016-09-18 16:25:00'),('400874526',2,2016,'NFL_20160918_IND@DEN','DEN','IND',0,0,'2016-09-18 16:25:00'),('400874527',1,2016,'NFL_20160911_CIN@NYJ','NYJ','CIN',0,0,'2016-09-11 13:00:00'),('400874528',16,2016,'NFL_20161224_SD@CLE','CLE','SD',0,0,'2016-12-24 13:00:00'),('400874529',2,2016,'NFL_20160918_NO@NYG','NYG','NO',0,0,'2016-09-18 13:00:00'),('400874530',2,2016,'NFL_20160915_NYJ@BUF','BUF','NYJ',0,0,'2016-09-15 20:25:00'),('400874531',10,2016,'NFL_20161114_CIN@NYG','NYG','CIN',0,0,'2016-11-14 20:30:00'),('400874532',1,2016,'NFL_20160912_LAR@SF','SF','LAR',0,0,'2016-09-12 22:20:00'),('400874533',5,2016,'NFL_20161009_PHI@DET','DET','PHI',0,0,'2016-10-09 13:00:00'),('400874534',16,2016,'NFL_20161224_WAS@CHI','CHI','WAS',0,0,'2016-12-24 13:00:00'),('400874535',2,2016,'NFL_20160918_SF@CAR','CAR','SF',0,0,'2016-09-18 13:00:00'),('400874536',10,2016,'NFL_20161113_SEA@NE','NE','SEA',0,0,'2016-11-13 20:30:00'),('400874537',1,2016,'NFL_20160912_PIT@WAS','WAS','PIT',0,0,'2016-09-12 19:10:00'),('400874538',10,2016,'NFL_20161113_DAL@PIT','PIT','DAL',0,0,'2016-11-13 16:25:00'),('400874539',1,2016,'NFL_20160911_NE@ARI','ARI','NE',0,0,'2016-09-11 20:30:00'),('400874540',16,2016,'NFL_20161224_ATL@CAR','CAR','ATL',0,0,'2016-12-24 13:00:00'),('400874541',2,2016,'NFL_20160918_MIA@NE','NE','MIA',0,0,'2016-09-18 13:00:00'),('400874542',10,2016,'NFL_20161113_SF@ARI','ARI','SF',0,0,'2016-11-13 16:25:00'),('400874543',1,2016,'NFL_20160911_OAK@NO','NO','OAK',0,0,'2016-09-11 13:00:00'),('400874544',10,2016,'NFL_20161113_MIA@SD','SD','MIA',0,0,'2016-11-13 16:05:00'),('400874545',2,2016,'NFL_20160918_GB@MIN','MIN','GB',0,0,'2016-09-18 20:30:00'),('400874546',16,2016,'NFL_20161224_IND@OAK','OAK','IND',0,0,'2016-12-24 16:05:00'),('400874547',2,2016,'NFL_20160919_PHI@CHI','CHI','PHI',0,0,'2016-09-19 20:30:00'),('400874548',5,2016,'NFL_20161009_CHI@IND','IND','CHI',0,0,'2016-10-09 13:00:00'),('400874549',2,2016,'NFL_20160918_KC@HOU','HOU','KC',0,0,'2016-09-18 13:00:00'),('400874550',14,2016,'NFL_20161211_NO@TB','TB','NO',0,0,'2016-12-11 13:00:00'),('400874551',3,2016,'NFL_20160922_HOU@NE','NE','HOU',0,0,'2016-09-22 20:25:00'),('400874552',14,2016,'NFL_20161211_WAS@PHI','PHI','WAS',0,0,'2016-12-11 13:00:00'),('400874553',8,2016,'NFL_20161027_JAC@TEN','TEN','JAC',0,0,'2016-10-27 20:25:00'),('400874554',12,2016,'NFL_20161127_JAC@BUF','BUF','JAC',0,0,'2016-11-27 13:00:00'),('400874555',8,2016,'NFL_20161030_WAS@CIN','CIN','WAS',0,0,'2016-10-30 09:30:00'),('400874556',14,2016,'NFL_20161211_ARI@MIA','MIA','ARI',0,0,'2016-12-11 13:00:00'),('400874557',8,2016,'NFL_20161030_KC@IND','IND','KC',0,0,'2016-10-30 13:00:00'),('400874558',3,2016,'NFL_20160925_ARI@BUF','BUF','ARI',0,0,'2016-09-25 13:00:00'),('400874559',14,2016,'NFL_20161211_SD@CAR','CAR','SD',0,0,'2016-12-11 13:00:00'),('400874560',12,2016,'NFL_20161127_CIN@BAL','BAL','CIN',0,0,'2016-11-27 13:00:00'),('400874561',8,2016,'NFL_20161030_OAK@TB','TB','OAK',0,0,'2016-10-30 13:00:00'),('400874562',3,2016,'NFL_20160925_OAK@TEN','TEN','OAK',0,0,'2016-09-25 13:00:00'),('400874563',14,2016,'NFL_20161211_CIN@CLE','CLE','CIN',0,0,'2016-12-11 13:00:00'),('400874564',8,2016,'NFL_20161030_SEA@NO','NO','SEA',0,0,'2016-10-30 13:00:00'),('400874565',3,2016,'NFL_20160925_CLE@MIA','MIA','CLE',0,0,'2016-09-25 13:00:00'),('400874566',12,2016,'NFL_20161127_ARI@ATL','ATL','ARI',0,0,'2016-11-27 13:00:00'),('400874567',3,2016,'NFL_20160925_BAL@JAC','JAC','BAL',0,0,'2016-09-25 13:00:00'),('400874568',14,2016,'NFL_20161211_CHI@DET','DET','CHI',0,0,'2016-12-11 13:00:00'),('400874569',8,2016,'NFL_20161030_DET@HOU','HOU','DET',0,0,'2016-10-30 13:00:00'),('400874570',1,2016,'NFL_20160911_SD@KC','KC','SD',0,0,'2016-09-11 13:00:00'),('400874571',16,2016,'NFL_20161224_ARI@SEA','SEA','ARI',0,0,'2016-12-24 16:25:00'),('400874572',10,2016,'NFL_20161113_GB@TEN','TEN','GB',0,0,'2016-11-13 13:00:00'),('400874573',1,2016,'NFL_20160911_DET@IND','IND','DET',0,0,'2016-09-11 16:25:00'),('400874574',1,2016,'NFL_20160911_NYG@DAL','DAL','NYG',0,0,'2016-09-11 16:25:00'),('400874575',16,2016,'NFL_20161224_SF@LAR','LAR','SF',0,0,'2016-12-24 16:25:00'),('400874576',10,2016,'NFL_20161113_MIN@WAS','WAS','MIN',0,0,'2016-11-13 13:00:00'),('400874577',1,2016,'NFL_20160911_MIA@SEA','SEA','MIA',0,0,'2016-09-11 16:05:00'),('400874578',10,2016,'NFL_20161113_CHI@TB','TB','CHI',0,0,'2016-11-13 13:00:00'),('400874579',16,2016,'NFL_20161224_CIN@HOU','HOU','CIN',0,0,'2016-12-24 20:25:00'),('400874580',10,2016,'NFL_20161113_KC@CAR','CAR','KC',0,0,'2016-11-13 13:00:00'),('400874581',5,2016,'NFL_20161009_TEN@MIA','MIA','TEN',0,0,'2016-10-09 13:00:00'),('400874582',10,2016,'NFL_20161113_ATL@PHI','PHI','ATL',0,0,'2016-11-13 13:00:00'),('400874583',16,2016,'NFL_20161225_BAL@PIT','PIT','BAL',0,0,'2016-12-25 16:30:00'),('400874584',10,2016,'NFL_20161113_LAR@NYJ','NYJ','LAR',0,0,'2016-11-13 13:00:00'),('400874585',16,2016,'NFL_20161225_DEN@KC','KC','DEN',0,0,'2016-12-25 20:30:00'),('400874586',10,2016,'NFL_20161113_DEN@NO','NO','DEN',0,0,'2016-11-13 13:00:00'),('400874587',10,2016,'NFL_20161113_HOU@JAC','JAC','HOU',0,0,'2016-11-13 13:00:00'),('400874588',16,2016,'NFL_20161226_DET@DAL','DAL','DET',0,0,'2016-12-26 20:30:00'),('400874589',10,2016,'NFL_20161110_CLE@BAL','BAL','CLE',0,0,'2016-11-10 20:25:00'),('400874590',5,2016,'NFL_20161009_WAS@BAL','BAL','WAS',0,0,'2016-10-09 13:00:00'),('400874591',9,2016,'NFL_20161107_BUF@SEA','SEA','BUF',0,0,'2016-11-07 20:30:00'),('400874592',9,2016,'NFL_20161106_DEN@OAK','OAK','DEN',0,0,'2016-11-06 20:30:00'),('400874593',9,2016,'NFL_20161106_TEN@SD','SD','TEN',0,0,'2016-11-06 16:25:00'),('400874594',9,2016,'NFL_20161106_IND@GB','GB','IND',0,0,'2016-11-06 16:25:00'),('400874595',5,2016,'NFL_20161009_HOU@MIN','MIN','HOU',0,0,'2016-10-09 13:00:00'),('400874596',9,2016,'NFL_20161106_CAR@LAR','LAR','CAR',0,0,'2016-11-06 16:05:00'),('400874597',9,2016,'NFL_20161106_NO@SF','SF','NO',0,0,'2016-11-06 16:05:00'),('400874598',9,2016,'NFL_20161106_PIT@BAL','BAL','PIT',0,0,'2016-11-06 13:00:00'),('400874599',9,2016,'NFL_20161106_DAL@CLE','CLE','DAL',0,0,'2016-11-06 13:00:00'),('400874600',9,2016,'NFL_20161106_JAC@KC','KC','JAC',0,0,'2016-11-06 13:00:00'),('400874601',9,2016,'NFL_20161106_NYJ@MIA','MIA','NYJ',0,0,'2016-11-06 13:00:00'),('400874602',5,2016,'NFL_20161009_NYJ@PIT','PIT','NYJ',0,0,'2016-10-09 13:00:00'),('400874603',9,2016,'NFL_20161106_PHI@NYG','NYG','PHI',0,0,'2016-11-06 13:00:00'),('400874604',9,2016,'NFL_20161106_DET@MIN','MIN','DET',0,0,'2016-11-06 13:00:00'),('400874605',9,2016,'NFL_20161103_ATL@TB','TB','ATL',0,0,'2016-11-03 20:25:00'),('400874606',17,2016,'NFL_20170101_NO@ATL','ATL','NO',0,0,'2017-01-01 13:00:00'),('400874607',5,2016,'NFL_20161009_ATL@DEN','DEN','ATL',0,0,'2016-10-09 16:05:00'),('400874608',17,2016,'NFL_20170101_BAL@CIN','CIN','BAL',0,0,'2017-01-01 13:00:00'),('400874609',11,2016,'NFL_20161117_NO@CAR','CAR','NO',0,0,'2016-11-17 20:25:00'),('400874610',3,2016,'NFL_20160925_DET@GB','GB','DET',0,0,'2016-09-25 13:00:00'),('400874611',14,2016,'NFL_20161211_HOU@IND','IND','HOU',0,0,'2016-12-11 13:00:00'),('400874612',8,2016,'NFL_20161030_NYJ@CLE','CLE','NYJ',0,0,'2016-10-30 13:00:00'),('400874613',3,2016,'NFL_20160925_DEN@CIN','CIN','DEN',0,0,'2016-09-25 13:00:00'),('400874614',12,2016,'NFL_20161127_NYG@CLE','CLE','NYG',0,0,'2016-11-27 13:00:00'),('400874615',3,2016,'NFL_20160925_MIN@CAR','CAR','MIN',0,0,'2016-09-25 13:00:00'),('400874616',8,2016,'NFL_20161030_GB@ATL','ATL','GB',0,0,'2016-10-30 13:00:00'),('400874617',14,2016,'NFL_20161211_MIN@JAC','JAC','MIN',0,0,'2016-12-11 13:00:00'),('400874618',3,2016,'NFL_20160925_LAR@TB','TB','LAR',0,0,'2016-09-25 16:05:00'),('400874619',8,2016,'NFL_20161030_NE@BUF','BUF','NE',0,0,'2016-10-30 13:00:00'),('400874620',3,2016,'NFL_20160925_SF@SEA','SEA','SF',0,0,'2016-09-25 16:05:00'),('400874621',14,2016,'NFL_20161211_NYJ@SF','SF','NYJ',0,0,'2016-12-11 16:05:00'),('400874622',8,2016,'NFL_20161030_SD@DEN','DEN','SD',0,0,'2016-10-30 16:05:00'),('400874623',3,2016,'NFL_20160925_NYJ@KC','KC','NYJ',0,0,'2016-09-25 16:25:00'),('400874624',3,2016,'NFL_20160925_SD@IND','IND','SD',0,0,'2016-09-25 16:25:00'),('400874625',8,2016,'NFL_20161030_ARI@CAR','CAR','ARI',0,0,'2016-10-30 16:25:00'),('400874626',12,2016,'NFL_20161127_LAR@NO','NO','LAR',0,0,'2016-11-27 13:00:00'),('400874627',14,2016,'NFL_20161211_ATL@LAR','LAR','ATL',0,0,'2016-12-11 16:25:00'),('400874628',3,2016,'NFL_20160925_PIT@PHI','PHI','PIT',0,0,'2016-09-25 16:25:00'),('400874629',8,2016,'NFL_20161030_PHI@DAL','DAL','PHI',0,0,'2016-10-30 20:30:00'),('400874630',5,2016,'NFL_20161009_CIN@DAL','DAL','CIN',0,0,'2016-10-09 16:25:00'),('400874631',17,2016,'NFL_20170101_NYG@WAS','WAS','NYG',0,0,'2017-01-01 13:00:00'),('400874632',17,2016,'NFL_20170101_HOU@TEN','TEN','HOU',0,0,'2017-01-01 13:00:00'),('400874633',5,2016,'NFL_20161009_BUF@LAR','LAR','BUF',0,0,'2016-10-09 16:25:00'),('400874634',11,2016,'NFL_20161120_PIT@CLE','CLE','PIT',0,0,'2016-11-20 13:00:00'),('400874635',17,2016,'NFL_20170101_CAR@TB','TB','CAR',0,0,'2017-01-01 13:00:00'),('400874636',5,2016,'NFL_20161009_SD@OAK','OAK','SD',0,0,'2016-10-09 16:25:00'),('400874637',17,2016,'NFL_20170101_GB@DET','DET','GB',0,0,'2017-01-01 13:00:00'),('400874638',11,2016,'NFL_20161120_BAL@DAL','DAL','BAL',0,0,'2016-11-20 13:00:00'),('400874639',17,2016,'NFL_20170101_JAC@IND','IND','JAC',0,0,'2017-01-01 13:00:00'),('400874640',5,2016,'NFL_20161009_NYG@GB','GB','NYG',0,0,'2016-10-09 20:30:00'),('400874641',11,2016,'NFL_20161120_JAC@DET','DET','JAC',0,0,'2016-11-20 13:00:00'),('400874642',17,2016,'NFL_20170101_NE@MIA','MIA','NE',0,0,'2017-01-01 13:00:00'),('400874643',17,2016,'NFL_20170101_CHI@MIN','MIN','CHI',0,0,'2017-01-01 13:00:00'),('400874644',11,2016,'NFL_20161120_TEN@IND','IND','TEN',0,0,'2016-11-20 13:00:00'),('400874645',17,2016,'NFL_20170101_BUF@NYJ','NYJ','BUF',0,0,'2017-01-01 13:00:00'),('400874646',11,2016,'NFL_20161120_BUF@CIN','CIN','BUF',0,0,'2016-11-20 13:00:00'),('400874647',17,2016,'NFL_20170101_DAL@PHI','PHI','DAL',0,0,'2017-01-01 13:00:00'),('400874648',5,2016,'NFL_20161010_TB@CAR','CAR','TB',0,0,'2016-10-10 20:30:00'),('400874649',11,2016,'NFL_20161120_TB@KC','KC','TB',0,0,'2016-11-20 13:00:00'),('400874650',3,2016,'NFL_20160925_CHI@DAL','DAL','CHI',0,0,'2016-09-25 20:30:00'),('400874651',14,2016,'NFL_20161211_SEA@GB','GB','SEA',0,0,'2016-12-11 16:25:00'),('400874652',8,2016,'NFL_20161031_MIN@CHI','CHI','MIN',0,0,'2016-10-31 20:30:00'),('400874653',3,2016,'NFL_20160926_ATL@NO','NO','ATL',0,0,'2016-09-26 20:30:00'),('400874654',12,2016,'NFL_20161127_SF@MIA','MIA','SF',0,0,'2016-11-27 13:00:00'),('400874655',4,2016,'NFL_20160929_MIA@CIN','CIN','MIA',0,0,'2016-09-29 20:25:00'),('400874656',14,2016,'NFL_20161211_DAL@NYG','NYG','DAL',0,0,'2016-12-11 20:30:00'),('400874657',4,2016,'NFL_20161002_IND@JAC','JAC','IND',0,0,'2016-10-02 09:30:00'),('400874658',4,2016,'NFL_20161002_TEN@HOU','HOU','TEN',0,0,'2016-10-02 13:00:00'),('400874659',12,2016,'NFL_20161127_SD@HOU','HOU','SD',0,0,'2016-11-27 13:00:00'),('400874660',4,2016,'NFL_20161002_CLE@WAS','WAS','CLE',0,0,'2016-10-02 13:00:00'),('400874661',14,2016,'NFL_20161212_BAL@NE','NE','BAL',0,0,'2016-12-12 20:30:00'),('400874662',4,2016,'NFL_20161002_SEA@NYJ','NYJ','SEA',0,0,'2016-10-02 13:00:00'),('400874663',4,2016,'NFL_20161002_BUF@NE','NE','BUF',0,0,'2016-10-02 13:00:00'),('400874664',4,2016,'NFL_20161002_CAR@ATL','ATL','CAR',0,0,'2016-10-02 13:00:00'),('400874665',12,2016,'NFL_20161127_SEA@TB','TB','SEA',0,0,'2016-11-27 16:05:00'),('400874666',4,2016,'NFL_20161002_OAK@BAL','BAL','OAK',0,0,'2016-10-02 13:00:00'),('400874667',15,2016,'NFL_20161215_LAR@SEA','SEA','LAR',0,0,'2016-12-15 20:25:00'),('400874668',4,2016,'NFL_20161002_DET@CHI','CHI','DET',0,0,'2016-10-02 13:00:00'),('400874669',4,2016,'NFL_20161002_DEN@TB','TB','DEN',0,0,'2016-10-02 16:05:00'),('400874670',12,2016,'NFL_20161127_CAR@OAK','OAK','CAR',0,0,'2016-11-27 16:25:00'),('400874671',4,2016,'NFL_20161002_LAR@ARI','ARI','LAR',0,0,'2016-10-02 16:25:00'),('400874672',4,2016,'NFL_20161002_NO@SD','SD','NO',0,0,'2016-10-02 16:25:00'),('400874673',15,2016,'NFL_20161217_MIA@NYJ','NYJ','MIA',0,0,'2016-12-17 20:25:00'),('400874674',4,2016,'NFL_20161002_DAL@SF','SF','DAL',0,0,'2016-10-02 16:25:00'),('400874675',4,2016,'NFL_20161002_KC@PIT','PIT','KC',0,0,'2016-10-02 20:30:00'),('400874676',12,2016,'NFL_20161127_KC@DEN','DEN','KC',0,0,'2016-11-27 16:25:00'),('400874677',4,2016,'NFL_20161003_NYG@MIN','MIN','NYG',0,0,'2016-10-03 20:30:00'),('400874678',15,2016,'NFL_20161218_GB@CHI','CHI','GB',0,0,'2016-12-18 13:00:00'),('400874679',15,2016,'NFL_20161218_TB@DAL','DAL','TB',0,0,'2016-12-18 13:00:00'),('400874680',12,2016,'NFL_20161127_NE@NYJ','NYJ','NE',0,0,'2016-11-27 20:30:00'),('400874681',15,2016,'NFL_20161218_JAC@HOU','HOU','JAC',0,0,'2016-12-18 13:00:00'),('400874682',3,2016,'NFL_20160925_WAS@NYG','NYG','WAS',0,0,'2016-09-25 13:00:00'),('400874683',15,2016,'NFL_20161218_CLE@BUF','BUF','CLE',0,0,'2016-12-18 13:00:00'),('400874684',12,2016,'NFL_20161128_GB@PHI','PHI','GB',0,0,'2016-11-28 20:30:00'),('400874685',15,2016,'NFL_20161218_PHI@BAL','BAL','PHI',0,0,'2016-12-18 13:00:00'),('400874686',15,2016,'NFL_20161218_TEN@KC','KC','TEN',0,0,'2016-12-18 13:00:00'),('400874687',15,2016,'NFL_20161218_DET@NYG','NYG','DET',0,0,'2016-12-18 13:00:00'),('400874688',15,2016,'NFL_20161218_IND@MIN','MIN','IND',0,0,'2016-12-18 13:00:00'),('400874689',15,2016,'NFL_20161218_NO@ARI','ARI','NO',0,0,'2016-12-18 16:05:00'),('400874690',17,2016,'NFL_20170101_CLE@PIT','PIT','CLE',0,0,'2017-01-01 13:00:00'),('400874691',11,2016,'NFL_20161120_CHI@NYG','NYG','CHI',0,0,'2016-11-20 13:00:00'),('400874692',17,2016,'NFL_20170101_ARI@LAR','LAR','ARI',0,0,'2017-01-01 16:25:00'),('400874693',6,2016,'NFL_20161013_DEN@SD','SD','DEN',0,0,'2016-10-13 20:25:00'),('400874694',17,2016,'NFL_20170101_OAK@DEN','DEN','OAK',0,0,'2017-01-01 16:25:00'),('400874695',11,2016,'NFL_20161120_ARI@MIN','MIN','ARI',0,0,'2016-11-20 13:00:00'),('400874696',17,2016,'NFL_20170101_KC@SD','SD','KC',0,0,'2017-01-01 16:25:00'),('400874697',11,2016,'NFL_20161120_MIA@LAR','LAR','MIA',0,0,'2016-11-20 16:05:00'),('400874698',6,2016,'NFL_20161016_SF@BUF','BUF','SF',0,0,'2016-10-16 13:00:00'),('400874699',17,2016,'NFL_20170101_SEA@SF','SF','SEA',0,0,'2017-01-01 16:25:00'),('400874700',11,2016,'NFL_20161120_NE@SF','SF','NE',0,0,'2016-11-20 16:25:00'),('400874701',6,2016,'NFL_20161016_PHI@WAS','WAS','PHI',0,0,'2016-10-16 13:00:00'),('400874702',11,2016,'NFL_20161120_PHI@SEA','SEA','PHI',0,0,'2016-11-20 16:25:00'),('400874703',6,2016,'NFL_20161016_CLE@TEN','TEN','CLE',0,0,'2016-10-16 13:00:00'),('400874704',11,2016,'NFL_20161120_GB@WAS','WAS','GB',0,0,'2016-11-20 20:30:00'),('400874705',6,2016,'NFL_20161016_BAL@NYG','NYG','BAL',0,0,'2016-10-16 13:00:00'),('400874706',11,2016,'NFL_20161121_HOU@OAK','OAK','HOU',0,0,'2016-11-21 20:30:00'),('400874707',6,2016,'NFL_20161016_CAR@NO','NO','CAR',0,0,'2016-10-16 13:00:00'),('400874708',6,2016,'NFL_20161016_JAC@CHI','CHI','JAC',0,0,'2016-10-16 13:00:00'),('400874709',6,2016,'NFL_20161016_LAR@DET','DET','LAR',0,0,'2016-10-16 13:00:00'),('400874710',15,2016,'NFL_20161218_SF@ATL','ATL','SF',0,0,'2016-12-18 16:05:00'),('400874711',15,2016,'NFL_20161218_NE@DEN','DEN','NE',0,0,'2016-12-18 16:25:00'),('400874712',15,2016,'NFL_20161218_OAK@SD','SD','OAK',0,0,'2016-12-18 16:25:00'),('400874713',13,2016,'NFL_20161201_DAL@MIN','MIN','DAL',0,0,'2016-12-01 20:25:00'),('400874714',15,2016,'NFL_20161218_PIT@CIN','CIN','PIT',0,0,'2016-12-18 20:30:00'),('400874715',13,2016,'NFL_20161204_KC@ATL','ATL','KC',0,0,'2016-12-04 13:00:00'),('400874716',15,2016,'NFL_20161219_CAR@WAS','WAS','CAR',0,0,'2016-12-19 20:30:00'),('400874717',13,2016,'NFL_20161204_DET@NO','NO','DET',0,0,'2016-12-04 13:00:00'),('400874718',13,2016,'NFL_20161204_LAR@NE','NE','LAR',0,0,'2016-12-04 13:00:00'),('400874719',13,2016,'NFL_20161204_DEN@JAC','JAC','DEN',0,0,'2016-12-04 13:00:00'),('400874720',13,2016,'NFL_20161204_HOU@GB','GB','HOU',0,0,'2016-12-04 13:00:00'),('400874721',13,2016,'NFL_20161204_PHI@CIN','CIN','PHI',0,0,'2016-12-04 13:00:00'),('400874722',13,2016,'NFL_20161204_MIA@BAL','BAL','MIA',0,0,'2016-12-04 13:00:00'),('400874723',13,2016,'NFL_20161204_SF@CHI','CHI','SF',0,0,'2016-12-04 13:00:00'),('400874724',13,2016,'NFL_20161204_BUF@OAK','OAK','BUF',0,0,'2016-12-04 16:05:00'),('400874725',13,2016,'NFL_20161204_NYG@PIT','PIT','NYG',0,0,'2016-12-04 16:25:00'),('400874726',13,2016,'NFL_20161204_WAS@ARI','ARI','WAS',0,0,'2016-12-04 16:25:00'),('400874727',13,2016,'NFL_20161204_TB@SD','SD','TB',0,0,'2016-12-04 16:25:00'),('400874728',13,2016,'NFL_20161204_CAR@SEA','SEA','CAR',0,0,'2016-12-04 20:30:00'),('400874729',13,2016,'NFL_20161205_IND@NYJ','NYJ','IND',0,0,'2016-12-05 20:30:00'),('400874730',6,2016,'NFL_20161016_PIT@MIA','MIA','PIT',0,0,'2016-10-16 13:00:00'),('400874731',6,2016,'NFL_20161016_KC@OAK','OAK','KC',0,0,'2016-10-16 16:05:00'),('400874732',6,2016,'NFL_20161016_ATL@SEA','SEA','ATL',0,0,'2016-10-16 16:25:00'),('400874733',6,2016,'NFL_20161016_DAL@GB','GB','DAL',0,0,'2016-10-16 16:25:00'),('400874734',6,2016,'NFL_20161016_IND@HOU','HOU','IND',0,0,'2016-10-16 20:30:00'),('400874735',6,2016,'NFL_20161017_NYJ@ARI','ARI','NYJ',0,0,'2016-10-17 20:30:00'),('400874736',6,2016,'NFL_20161016_CIN@NE','NE','CIN',0,0,'2016-10-16 13:00:00');
/*!40000 ALTER TABLE `nfl_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nfl_team`
--

DROP TABLE IF EXISTS `nfl_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_team` (
  `teamId` char(3) NOT NULL,
  `name` varchar(40) NOT NULL,
  `city` varchar(40) NOT NULL,
  `conf` varchar(15) NOT NULL,
  `division` varchar(15) NOT NULL,
  PRIMARY KEY (`teamId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_team`
--

LOCK TABLES `nfl_team` WRITE;
/*!40000 ALTER TABLE `nfl_team` DISABLE KEYS */;
INSERT INTO `nfl_team` VALUES ('ARI','Cardinals','Arizona','NFC','West'),('ATL','Falcons','Atlanta','NFC','South'),('BAL','Ravens','Baltimore','AFC','North'),('BUF','Bills','Buffalo','AFC','East'),('CAR','Panthers','Carolina','NFC','South'),('CHI','Bears','Chicago','NFC','North'),('CIN','Bengals','Cincinnati','AFC','North'),('CLE','Browns','Cleveland','AFC','North'),('DAL','Cowboys','Dallas','NFC','East'),('DEN','Broncos','Denver','AFC','West'),('DET','Lions','Detroit','NFC','North'),('GB','Packers','Green Bay','NFC','North'),('HOU','Texans','Houston','AFC','South'),('IND','Colts','Indianapolis','AFC','South'),('JAC','Jaguars','Jacksonville','AFC','South'),('KC','Chiefs','Kansas City','AFC','West'),('LAR','Rams','Los Angeles','NFC','West'),('MIA','Dolphins','Miami','AFC','East'),('MIN','Vikings','Minnesota','NFC','North'),('NE','Patriots','New England','AFC','East'),('NO','Saints','New Orleans','NFC','South'),('NYG','Giants','New York','NFC','East'),('NYJ','Jets','New York','AFC','East'),('OAK','Raiders','Oakland','AFC','West'),('PHI','Eagles','Philadelphia','NFC','East'),('PIT','Steelers','Pittsburgh','AFC','North'),('SD','Chargers','San Diego','AFC','West'),('SEA','Seahawks','Seattle','NFC','West'),('SF','49ers','San Fransisco','NFC','West'),('TB','Buccaneers','Tampa Bay','NFC','South'),('TEN','Titans','Tennessee','AFC','South'),('WAS','Redskins','Washington','NFC','East');
/*!40000 ALTER TABLE `nfl_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nfl_vegas`
--

DROP TABLE IF EXISTS `nfl_vegas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nfl_vegas` (
  `gameId` char(40) NOT NULL,
  `g_mnemonic` varchar(75) NOT NULL,
  `h_opening_line` decimal(3,1) DEFAULT NULL,
  `h_opening_ou` decimal(3,1) DEFAULT NULL,
  `h_bovada_line` decimal(3,1) DEFAULT NULL,
  `h_bovada_ou` decimal(3,1) DEFAULT NULL,
  `h_caesars_line` decimal(3,1) DEFAULT NULL,
  `h_caesars_ou` decimal(3,1) DEFAULT NULL,
  `h_westgate_line` decimal(3,1) DEFAULT NULL,
  `h_westgate_ou` decimal(3,1) DEFAULT NULL,
  `h_betonline_line` decimal(3,1) DEFAULT NULL,
  `h_betonline_ou` decimal(3,1) DEFAULT NULL,
  `h_mybookie_line` decimal(3,1) DEFAULT NULL,
  `h_mybookie_ou` decimal(3,1) DEFAULT NULL,
  `h_5dimes_line` decimal(3,1) DEFAULT NULL,
  `h_5dimes_ou` decimal(3,1) DEFAULT NULL,
  `h_topbet_line` decimal(3,1) DEFAULT NULL,
  `h_topbet_ou` decimal(3,1) DEFAULT NULL,
  `h_betdsi_line` decimal(3,1) DEFAULT NULL,
  `h_betdsi_ou` decimal(3,1) DEFAULT NULL,
  `h_gtbets_line` decimal(3,1) DEFAULT NULL,
  `h_gtbets_ou` decimal(3,1) DEFAULT NULL,
  `h_sportsbetting_line` decimal(3,1) DEFAULT NULL,
  `h_sportsbetting_ou` decimal(3,1) DEFAULT NULL,
  `h_sportbet_line` decimal(3,1) DEFAULT NULL,
  `h_sportbet_ou` decimal(3,1) DEFAULT NULL,
  `h_station_line` decimal(3,1) DEFAULT NULL,
  `h_station_ou` decimal(3,1) DEFAULT NULL,
  `h_mirage_line` decimal(3,1) DEFAULT NULL,
  `h_mirage_ou` decimal(3,1) DEFAULT NULL,
  `h_wynn_line` decimal(3,1) DEFAULT NULL,
  `h_wynn_ou` decimal(3,1) DEFAULT NULL,
  `h_avg_line` decimal(3,1) DEFAULT NULL,
  `h_avg_ou` decimal(3,1) DEFAULT NULL,
  `h_median_line` decimal(3,1) DEFAULT NULL,
  `h_median_ou` decimal(3,1) DEFAULT NULL,
  `h_high_line` decimal(3,1) DEFAULT NULL,
  `h_low_line` decimal(3,1) DEFAULT NULL,
  `h_high_ou` decimal(3,1) DEFAULT NULL,
  `h_low_ou` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nfl_vegas`
--

LOCK TABLES `nfl_vegas` WRITE;
/*!40000 ALTER TABLE `nfl_vegas` DISABLE KEYS */;
/*!40000 ALTER TABLE `nfl_vegas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-14  7:54:31
