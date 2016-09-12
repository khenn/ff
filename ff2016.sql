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
INSERT INTO `nfl_schedule` VALUES ('0006fae68bf63683931cbe2ffbfa44cb',17,2016,'NFL_20170101_NO@ATL','ATL','NO',0,0,'2017-01-01 13:00:00'),('00c40f3de0a49adc2ca7b97da3a125a8',15,2016,'NFL_20161218_SF@ATL','ATL','SF',0,0,'2016-12-18 16:05:00'),('00ddf717aca300fe30cf1633a74f9089',12,2016,'NFL_20161128_GB@PHI','PHI','GB',0,0,'2016-11-28 20:30:00'),('013c5250a351d278a84406932e14a7d1',15,2016,'NFL_20161218_PHI@BAL','BAL','PHI',0,0,'2016-12-18 13:00:00'),('01c81b151400575a6d76bb2fd4c63429',11,2016,'NFL_20161120_BUF@CIN','CIN','BUF',0,0,'2016-11-20 13:00:00'),('036d53c5974748fc73693cf060209b37',12,2016,'NFL_20161127_CIN@BAL','BAL','CIN',0,0,'2016-11-27 13:00:00'),('039ca62b467803db36c7e71a03959524',7,2016,'NFL_20161023_CLE@CIN','CIN','CLE',0,0,'2016-10-23 13:00:00'),('03c7a65ebf30cf49016648a3d4ce45ed',17,2016,'NFL_20170101_KC@SD','SD','KC',0,0,'2017-01-01 16:25:00'),('04045846b07af74f67b4b1d0e4472ebd',4,2016,'NFL_20161002_KC@PIT','PIT','KC',0,0,'2016-10-02 20:30:00'),('056a342ec0eb3fc29de85b6b349ebcf6',3,2016,'NFL_20160925_MIN@CAR','CAR','MIN',0,0,'2016-09-25 13:00:00'),('05bfa980b53ddc2504af5f49a237f0cb',15,2016,'NFL_20161218_TEN@KC','KC','TEN',0,0,'2016-12-18 13:00:00'),('05e7289f18bb418d22def0c86ffa792a',1,2016,'NFL_20160911_DET@IND','IND','DET',0,0,'2016-09-11 16:25:00'),('065f3cfeb96d1ed17946852a190a1812',5,2016,'NFL_20161009_CHI@IND','IND','CHI',0,0,'2016-10-09 13:00:00'),('079e9024c78b056be3c1b131f8ee9c8e',3,2016,'NFL_20160925_SD@IND','IND','SD',0,0,'2016-09-25 16:25:00'),('0b3c0d5e8ad07f10c191f6f2dc5c6124',16,2016,'NFL_20161224_MIA@BUF','BUF','MIA',0,0,'2016-12-24 13:00:00'),('0cd3f9f81f54dbd7cad28c0b8e818fc0',4,2016,'NFL_20161002_CLE@WAS','WAS','CLE',0,0,'2016-10-02 13:00:00'),('0d1b2f3d9221a75fa4802daff4e8fa28',9,2016,'NFL_20161107_BUF@SEA','SEA','BUF',0,0,'2016-11-07 20:30:00'),('0e29407f8cc6e7d2b2e30cf0145db97a',2,2016,'NFL_20160918_IND@DEN','DEN','IND',0,0,'2016-09-18 16:25:00'),('0f7842ab940a515827f8c1ade6ecaaa5',10,2016,'NFL_20161113_HOU@JAC','JAC','HOU',0,0,'2016-11-13 13:00:00'),('11063ee3205d639b6e89e0441f1af91f',3,2016,'NFL_20160922_HOU@NE','NE','HOU',0,0,'2016-09-22 20:25:00'),('111226a2cb904b7707237bdefc83775b',8,2016,'NFL_20161030_ARI@CAR','CAR','ARI',0,0,'2016-10-30 16:25:00'),('11d0ba0bc2c1ee7340a629ea40cb9e76',17,2016,'NFL_20170101_DAL@PHI','PHI','DAL',0,0,'2017-01-01 13:00:00'),('12afc73068f94ff5da350150ad064235',14,2016,'NFL_20161211_HOU@IND','IND','HOU',0,0,'2016-12-11 13:00:00'),('1343edef4b9a0a74a951c5da3eb5f48d',14,2016,'NFL_20161211_MIN@JAC','JAC','MIN',0,0,'2016-12-11 13:00:00'),('14a8251cd050476a30e47e2e7e8e6814',5,2016,'NFL_20161010_TB@CAR','CAR','TB',0,0,'2016-10-10 20:30:00'),('18848601d6ba16b3aa5180ced4dcd564',4,2016,'NFL_20161002_OAK@BAL','BAL','OAK',0,0,'2016-10-02 13:00:00'),('18cd346979b89e624c46be0736839062',13,2016,'NFL_20161201_DAL@MIN','MIN','DAL',0,0,'2016-12-01 20:25:00'),('1b83af73f19057735b048711180926f4',9,2016,'NFL_20161106_DEN@OAK','OAK','DEN',0,0,'2016-11-06 20:30:00'),('1d9149df8b21476b18754358f130ae4c',15,2016,'NFL_20161218_JAC@HOU','HOU','JAC',0,0,'2016-12-18 13:00:00'),('1ea7a7d65fdaa1071362afa16268ccaa',7,2016,'NFL_20161023_BUF@MIA','MIA','BUF',0,0,'2016-10-23 13:00:00'),('2139f118d1b9e36d097f73b4086efa18',13,2016,'NFL_20161204_DET@NO','NO','DET',0,0,'2016-12-04 13:00:00'),('2422efe76ff64f878efe047dc2556b12',15,2016,'NFL_20161219_CAR@WAS','WAS','CAR',0,0,'2016-12-19 20:30:00'),('247334016570d55b60fdbf069f6b1d43',1,2016,'NFL_20160911_BUF@BAL','BAL','BUF',0,0,'2016-09-11 13:00:00'),('24b081d88745ad093e70e1676101bd7b',4,2016,'NFL_20161002_IND@JAC','JAC','IND',0,0,'2016-10-02 09:30:00'),('24dab12fdfcfac1acb4b4315a12cd35f',16,2016,'NFL_20161224_IND@OAK','OAK','IND',0,0,'2016-12-24 16:05:00'),('24f12970301e5a2a81685f8fbe3b6423',8,2016,'NFL_20161030_SD@DEN','DEN','SD',0,0,'2016-10-30 16:05:00'),('250c6f9610132e8ab17db14164172338',17,2016,'NFL_20170101_GB@DET','DET','GB',0,0,'2017-01-01 13:00:00'),('268a8fd15625f018d80c1132585981db',11,2016,'NFL_20161120_GB@WAS','WAS','GB',0,0,'2016-11-20 20:30:00'),('27689b9f8f3efa56f2c8201ba8764299',1,2016,'NFL_20160911_NYG@DAL','DAL','NYG',0,0,'2016-09-11 16:25:00'),('29a6b696c02d613af953cc2c95e0386d',1,2016,'NFL_20160908_CAR@DEN','DEN','CAR',0,0,'2016-09-08 20:30:00'),('2a4a04f296fbfaa62eb05625df9459be',6,2016,'NFL_20161016_DAL@GB','GB','DAL',0,0,'2016-10-16 16:25:00'),('2b87f89d7a0e55bed7b546f7938257d5',14,2016,'NFL_20161211_DAL@NYG','NYG','DAL',0,0,'2016-12-11 20:30:00'),('2beb9c48bee12a457ea2a5fcccad32ad',6,2016,'NFL_20161016_CAR@NO','NO','CAR',0,0,'2016-10-16 13:00:00'),('2cbdb8551f71a19e6ee0f3341ad5edf2',7,2016,'NFL_20161023_IND@TEN','TEN','IND',0,0,'2016-10-23 13:00:00'),('2dfb1392273bc451819990a69a4e157c',3,2016,'NFL_20160925_DEN@CIN','CIN','DEN',0,0,'2016-09-25 13:00:00'),('2e19d8990b407a9613abf34f9f388ecb',7,2016,'NFL_20161023_NYG@LAR','LAR','NYG',0,0,'2016-10-23 09:30:00'),('3037a0a95274036687a03d5bb51fb622',11,2016,'NFL_20161121_HOU@OAK','OAK','HOU',0,0,'2016-11-21 20:30:00'),('3293e495e22d1908e6f1ed7cf95058ac',3,2016,'NFL_20160925_NYJ@KC','KC','NYJ',0,0,'2016-09-25 16:25:00'),('32db9342bcdc34a323146f55a9680552',3,2016,'NFL_20160926_ATL@NO','NO','ATL',0,0,'2016-09-26 20:30:00'),('333c201b4e94ff544494ba0f699069ce',5,2016,'NFL_20161009_NYJ@PIT','PIT','NYJ',0,0,'2016-10-09 13:00:00'),('334967e201cb41e8edc811323c3eece7',5,2016,'NFL_20161009_TEN@MIA','MIA','TEN',0,0,'2016-10-09 13:00:00'),('343810b8748c3b9edc0c57cfa6818bf4',6,2016,'NFL_20161016_PHI@WAS','WAS','PHI',0,0,'2016-10-16 13:00:00'),('348b8d392f0e09c33303cf426ee7b855',17,2016,'NFL_20170101_CAR@TB','TB','CAR',0,0,'2017-01-01 13:00:00'),('351dd3247c2995fdd4bde5ad95598a05',8,2016,'NFL_20161030_WAS@CIN','CIN','WAS',0,0,'2016-10-30 09:30:00'),('372e0e9c76d340a8c06af06b18c4f72b',5,2016,'NFL_20161009_PHI@DET','DET','PHI',0,0,'2016-10-09 13:00:00'),('382e9598e4fb7d6aba34944dd4e9b4ef',2,2016,'NFL_20160918_MIA@NE','NE','MIA',0,0,'2016-09-18 13:00:00'),('393cccd4912530b4db313fc50a90dd0d',3,2016,'NFL_20160925_BAL@JAC','JAC','BAL',0,0,'2016-09-25 13:00:00'),('3a525757d8e58595195d550d8c1d5556',12,2016,'NFL_20161127_SF@MIA','MIA','SF',0,0,'2016-11-27 13:00:00'),('3a9a10ee6fcbc471cb4224c11bfcebd8',15,2016,'NFL_20161218_NO@ARI','ARI','NO',0,0,'2016-12-18 16:05:00'),('3b0cd01615be074775b0e5b99e0a212f',16,2016,'NFL_20161226_DET@DAL','DAL','DET',0,0,'2016-12-26 20:30:00'),('3c2896256167c36beda471e68030f1ce',10,2016,'NFL_20161113_SEA@NE','NE','SEA',0,0,'2016-11-13 20:30:00'),('3ccbf96d69ec6d843e33191f2f371c98',2,2016,'NFL_20160918_DAL@WAS','WAS','DAL',0,0,'2016-09-18 13:00:00'),('3d0eb9083ada2eb519fe543a2e422366',9,2016,'NFL_20161106_DET@MIN','MIN','DET',0,0,'2016-11-06 13:00:00'),('3eae7cda728b78433e5ac6a177ceb336',15,2016,'NFL_20161218_OAK@SD','SD','OAK',0,0,'2016-12-18 16:25:00'),('3f49332043742d1d37eb0c57c366d7b2',7,2016,'NFL_20161023_OAK@JAC','JAC','OAK',0,0,'2016-10-23 13:00:00'),('3f55d078fe57162b2e8c06596b28e976',1,2016,'NFL_20160911_NE@ARI','ARI','NE',0,0,'2016-09-11 20:30:00'),('3f6ec109f7292d0e06ae88854d2b1c38',15,2016,'NFL_20161215_LAR@SEA','SEA','LAR',0,0,'2016-12-15 20:25:00'),('3ff6f6ce7a0af3642bafeb5d76a228bf',7,2016,'NFL_20161023_NE@PIT','PIT','NE',0,0,'2016-10-23 16:25:00'),('40c9d704e9e2db1136834c219711951f',6,2016,'NFL_20161016_CLE@TEN','TEN','CLE',0,0,'2016-10-16 13:00:00'),('40eef76c927dd45ed715acb1afcd9e6b',2,2016,'NFL_20160918_TEN@DET','DET','TEN',0,0,'2016-09-18 13:00:00'),('4141b43c63e1473f727893dc913314a6',10,2016,'NFL_20161113_GB@TEN','TEN','GB',0,0,'2016-11-13 13:00:00'),('41fdb267056175b9bf0e68fa0c71d20d',5,2016,'NFL_20161009_NE@CLE','CLE','NE',0,0,'2016-10-09 13:00:00'),('41fddd69373542c2391b2b0f7f5496c0',14,2016,'NFL_20161211_CHI@DET','DET','CHI',0,0,'2016-12-11 13:00:00'),('4291e2f4415535027b03cd98dcb57f8b',6,2016,'NFL_20161016_PIT@MIA','MIA','PIT',0,0,'2016-10-16 13:00:00'),('42c69670a26cd2138b179934b1e54f98',15,2016,'NFL_20161218_DET@NYG','NYG','DET',0,0,'2016-12-18 13:00:00'),('4336c816109c40146a9b5b30c37f2922',14,2016,'NFL_20161211_SEA@GB','GB','SEA',0,0,'2016-12-11 16:25:00'),('448b9423a8df36901ed9c09856aa17db',9,2016,'NFL_20161106_NYJ@MIA','MIA','NYJ',0,0,'2016-11-06 13:00:00'),('44beac770b2b77dc2ad351ccf4acb87d',4,2016,'NFL_20161002_DET@CHI','CHI','DET',0,0,'2016-10-02 13:00:00'),('45b1587db197ac695d0ce7592dfac79c',14,2016,'NFL_20161211_SD@CAR','CAR','SD',0,0,'2016-12-11 13:00:00'),('45d3a3a0c8da3c875fa18b3a3db33eb1',1,2016,'NFL_20160911_SD@KC','KC','SD',0,0,'2016-09-11 13:00:00'),('46b8184193f31830f517a83e330bf7b9',11,2016,'NFL_20161120_TB@KC','KC','TB',0,0,'2016-11-20 13:00:00'),('485c0717c2934b3357986e4c1f5feba2',3,2016,'NFL_20160925_PIT@PHI','PHI','PIT',0,0,'2016-09-25 16:25:00'),('49a2b14fbe354830774ab0befe0c9460',4,2016,'NFL_20161002_TEN@HOU','HOU','TEN',0,0,'2016-10-02 13:00:00'),('4ac962b4eccff39628f29d97883e8646',11,2016,'NFL_20161120_TEN@IND','IND','TEN',0,0,'2016-11-20 13:00:00'),('4cc8d834465d30ea13986f161d67600b',13,2016,'NFL_20161204_MIA@BAL','BAL','MIA',0,0,'2016-12-04 13:00:00'),('4e0ca5e5f62790bebe7278c8e5fde148',13,2016,'NFL_20161204_WAS@ARI','ARI','WAS',0,0,'2016-12-04 16:25:00'),('4e496d0f5d05326256f0820120ce9441',16,2016,'NFL_20161222_NYG@PHI','PHI','NYG',0,0,'2016-12-22 20:25:00'),('53008419b780e47961336f28490580b4',5,2016,'NFL_20161006_ARI@SF','SF','ARI',0,0,'2016-10-06 20:25:00'),('532bfd049bde94ee0fc986636ab26385',6,2016,'NFL_20161016_ATL@SEA','SEA','ATL',0,0,'2016-10-16 16:25:00'),('5360735bd8b1f95eda2acfbb9f13d82a',2,2016,'NFL_20160918_JAC@SD','SD','JAC',0,0,'2016-09-18 16:25:00'),('53d47e7c94a8c616cfda0c14990daa91',13,2016,'NFL_20161204_BUF@OAK','OAK','BUF',0,0,'2016-12-04 16:05:00'),('548e82bbd4736a41236e8c4b0fd6e8fd',15,2016,'NFL_20161218_TB@DAL','DAL','TB',0,0,'2016-12-18 13:00:00'),('55fc1350a2ca3045e4e748bca02fb3e9',12,2016,'NFL_20161127_SD@HOU','HOU','SD',0,0,'2016-11-27 13:00:00'),('56ad97d9a99ee56e02affb9250784167',3,2016,'NFL_20160925_SF@SEA','SEA','SF',0,0,'2016-09-25 16:05:00'),('59590905422520eb54c5b266224ae6ae',15,2016,'NFL_20161218_CLE@BUF','BUF','CLE',0,0,'2016-12-18 13:00:00'),('5ac103855c041285a58bb6e8f9d5d166',14,2016,'NFL_20161211_CIN@CLE','CLE','CIN',0,0,'2016-12-11 13:00:00'),('5ada6fcc22005c228ad9e540b7001575',13,2016,'NFL_20161204_LAR@NE','NE','LAR',0,0,'2016-12-04 13:00:00'),('5b3c96a5adb439fc9643f672d5b680cf',8,2016,'NFL_20161030_KC@IND','IND','KC',0,0,'2016-10-30 13:00:00'),('5f6e031b21d994fb21dfdf5d372e9149',15,2016,'NFL_20161218_PIT@CIN','CIN','PIT',0,0,'2016-12-18 20:30:00'),('600176fe9aaa6cf3950b1f474fb60d7e',3,2016,'NFL_20160925_CHI@DAL','DAL','CHI',0,0,'2016-09-25 20:30:00'),('60c052638ac7387f432893fbe1ecf8e0',4,2016,'NFL_20160929_MIA@CIN','CIN','MIA',0,0,'2016-09-29 20:25:00'),('610eb239626d00d3eb14898c3384e933',4,2016,'NFL_20161002_LAR@ARI','ARI','LAR',0,0,'2016-10-02 16:25:00'),('61b3eee41d3af8b08577b5ba7fe4dc8a',1,2016,'NFL_20160911_CLE@PHI','PHI','CLE',0,0,'2016-09-11 13:00:00'),('6218526c70a749682f6dbc0e8ca750aa',12,2016,'NFL_20161127_JAC@BUF','BUF','JAC',0,0,'2016-11-27 13:00:00'),('629b7ceaade92518995c10647504a8ad',10,2016,'NFL_20161113_CHI@TB','TB','CHI',0,0,'2016-11-13 13:00:00'),('62fe2bf4cbf8c6e17bcd1dd88f9f39ea',8,2016,'NFL_20161031_MIN@CHI','CHI','MIN',0,0,'2016-10-31 20:30:00'),('64bcab02e9d7817b9dfa05ebf6666b15',10,2016,'NFL_20161113_ATL@PHI','PHI','ATL',0,0,'2016-11-13 13:00:00'),('65f88a125fed2c24bc9a6c3bad6bf258',16,2016,'NFL_20161224_TEN@JAC','JAC','TEN',0,0,'2016-12-24 13:00:00'),('66edaccf92e1d3cbf71e96a508532162',13,2016,'NFL_20161204_CAR@SEA','SEA','CAR',0,0,'2016-12-04 20:30:00'),('670b1b0fd8deacae1ed8dfa3d7d36cac',3,2016,'NFL_20160925_OAK@TEN','TEN','OAK',0,0,'2016-09-25 13:00:00'),('67fdc73b703335c1cc85850bc28663c7',12,2016,'NFL_20161127_CAR@OAK','OAK','CAR',0,0,'2016-11-27 16:25:00'),('6832fa1faa0c388d3396d29746394458',1,2016,'NFL_20160912_LAR@SF','SF','LAR',0,0,'2016-09-12 22:20:00'),('6b258c092b824f853b96c2083f1f7aa6',17,2016,'NFL_20170101_SEA@SF','SF','SEA',0,0,'2017-01-01 16:25:00'),('6b2b9f1aa536def9dedfe02225073321',7,2016,'NFL_20161023_TB@SF','SF','TB',0,0,'2016-10-23 16:05:00'),('6caa461878860d69a65ca31084d826a2',9,2016,'NFL_20161106_PIT@BAL','BAL','PIT',0,0,'2016-11-06 13:00:00'),('6dac4e6ab1fe1204f9a22af9a2157d6d',14,2016,'NFL_20161211_NYJ@SF','SF','NYJ',0,0,'2016-12-11 16:05:00'),('6e0988639795b3912f41b2f402580556',13,2016,'NFL_20161204_DEN@JAC','JAC','DEN',0,0,'2016-12-04 13:00:00'),('6e6d83a0b2f519e3dcb0d6e04066a678',6,2016,'NFL_20161017_NYJ@ARI','ARI','NYJ',0,0,'2016-10-17 20:30:00'),('70d6e6b5d38658ccc5a5c4498b70e882',6,2016,'NFL_20161016_CIN@NE','NE','CIN',0,0,'2016-10-16 13:00:00'),('713b5579c73d3e0ce1e4d71f1b9ef02e',4,2016,'NFL_20161003_NYG@MIN','MIN','NYG',0,0,'2016-10-03 20:30:00'),('71b0701292b22aea9191c8dfd467677e',16,2016,'NFL_20161224_MIN@GB','GB','MIN',0,0,'2016-12-24 13:00:00'),('724712d795b22241717fc74d53e79ca1',16,2016,'NFL_20161224_SD@CLE','CLE','SD',0,0,'2016-12-24 13:00:00'),('724eeec0000a04d1c4f1a6bc7c0b8cfe',3,2016,'NFL_20160925_ARI@BUF','BUF','ARI',0,0,'2016-09-25 13:00:00'),('75c9659b34cb44797d52f34373197d1a',16,2016,'NFL_20161225_BAL@PIT','PIT','BAL',0,0,'2016-12-25 16:30:00'),('77b00434aad463d9c43b7c8d79316387',10,2016,'NFL_20161113_DAL@PIT','PIT','DAL',0,0,'2016-11-13 16:25:00'),('787f71f4198f465cb1b12af7930ae7dc',6,2016,'NFL_20161013_DEN@SD','SD','DEN',0,0,'2016-10-13 20:25:00'),('79d5b694264eb33dae2eaa5eba316cd8',8,2016,'NFL_20161030_GB@ATL','ATL','GB',0,0,'2016-10-30 13:00:00'),('7a9a973e59e953f66e6792b131c3594f',1,2016,'NFL_20160911_MIN@TEN','TEN','MIN',0,0,'2016-09-11 13:00:00'),('7bcb5b654a3fb3f588f519b1a182d6ed',10,2016,'NFL_20161114_CIN@NYG','NYG','CIN',0,0,'2016-11-14 20:30:00'),('7eb92ff3a26af39b6621cbf015b6613a',7,2016,'NFL_20161023_NO@KC','KC','NO',0,0,'2016-10-23 13:00:00'),('7fc6d3ef25c95f051c6163d24adf73d6',5,2016,'NFL_20161009_HOU@MIN','MIN','HOU',0,0,'2016-10-09 13:00:00'),('807a0d50239c0fe06b8131b4f7edc15b',17,2016,'NFL_20170101_CLE@PIT','PIT','CLE',0,0,'2017-01-01 13:00:00'),('83c75c25597fafe7b88f92135f2ea912',13,2016,'NFL_20161205_IND@NYJ','NYJ','IND',0,0,'2016-12-05 20:30:00'),('8509aade7557d53f0eb8d60dbff54fc1',15,2016,'NFL_20161218_GB@CHI','CHI','GB',0,0,'2016-12-18 13:00:00'),('859e1522d5be19d2a544d379a11d475a',10,2016,'NFL_20161113_MIN@WAS','WAS','MIN',0,0,'2016-11-13 13:00:00'),('86b6ddb5167443372555dba7f5f007aa',16,2016,'NFL_20161224_SF@LAR','LAR','SF',0,0,'2016-12-24 16:25:00'),('891592dab3aed9c6f6e0cdc351cefcfb',17,2016,'NFL_20170101_HOU@TEN','TEN','HOU',0,0,'2017-01-01 13:00:00'),('8a353d49240dc3b2fb8ef0686bfd22ea',6,2016,'NFL_20161016_IND@HOU','HOU','IND',0,0,'2016-10-16 20:30:00'),('8ad85d726022c7ccc5b8cf7c11991314',8,2016,'NFL_20161030_NYJ@CLE','CLE','NYJ',0,0,'2016-10-30 13:00:00'),('8b622232e3b26bfea6758730bbcba820',5,2016,'NFL_20161009_BUF@LAR','LAR','BUF',0,0,'2016-10-09 16:25:00'),('8bf0274d462be49e09a99886d52d1bb0',17,2016,'NFL_20170101_NE@MIA','MIA','NE',0,0,'2017-01-01 13:00:00'),('8d3a0b7fd3890a234c6044c97dbd51a0',10,2016,'NFL_20161113_DEN@NO','NO','DEN',0,0,'2016-11-13 13:00:00'),('8ffa5297ed675e13a4ae617a6d370b62',7,2016,'NFL_20161023_SD@ATL','ATL','SD',0,0,'2016-10-23 16:05:00'),('908f24af4330f9a231fb5363406d74c1',6,2016,'NFL_20161016_SF@BUF','BUF','SF',0,0,'2016-10-16 13:00:00'),('909dda445b8f68b85c580edb05f4adba',17,2016,'NFL_20170101_CHI@MIN','MIN','CHI',0,0,'2017-01-01 13:00:00'),('90a642f83e99936d97758f2136bd3757',12,2016,'NFL_20161127_KC@DEN','DEN','KC',0,0,'2016-11-27 16:25:00'),('90ac251250834401f869302bb19919a8',2,2016,'NFL_20160918_SEA@LAR','LAR','SEA',0,0,'2016-09-18 16:05:00'),('917554e29b7a5ee7cf12d942f8e31300',2,2016,'NFL_20160919_PHI@CHI','CHI','PHI',0,0,'2016-09-19 20:30:00'),('919afeec86a357ebb0cf83fef604729f',12,2016,'NFL_20161127_TEN@CHI','CHI','TEN',0,0,'2016-11-27 13:00:00'),('929e791907a428da35c1fb7c9a9ecf18',9,2016,'NFL_20161106_NO@SF','SF','NO',0,0,'2016-11-06 16:05:00'),('94186748d4b94a393c9718ec1f680e78',17,2016,'NFL_20170101_JAC@IND','IND','JAC',0,0,'2017-01-01 13:00:00'),('942bb585a74362764dcb5f94825d59e0',17,2016,'NFL_20170101_BUF@NYJ','NYJ','BUF',0,0,'2017-01-01 13:00:00'),('943dd6822d5ec9411de0d357ed20bd21',10,2016,'NFL_20161113_SF@ARI','ARI','SF',0,0,'2016-11-13 16:25:00'),('9641679ee9dc10abcdf885cf391788ed',11,2016,'NFL_20161120_ARI@MIN','MIN','ARI',0,0,'2016-11-20 13:00:00'),('96c40ac1ef7a080c02a04067e2b6b8c0',5,2016,'NFL_20161009_SD@OAK','OAK','SD',0,0,'2016-10-09 16:25:00'),('97310ede73337bd15d25225222c55ded',2,2016,'NFL_20160918_KC@HOU','HOU','KC',0,0,'2016-09-18 13:00:00'),('97e27716d7c4088465e174b022ad9390',2,2016,'NFL_20160918_ATL@OAK','OAK','ATL',0,0,'2016-09-18 16:25:00'),('97e4209b815dfb01b62fff5a322ef51e',12,2016,'NFL_20161124_WAS@DAL','DAL','WAS',0,0,'2016-11-24 16:30:00'),('9898fde24dc0eba4cc72dc49398eeb36',7,2016,'NFL_20161020_CHI@GB','GB','CHI',0,0,'2016-10-20 20:25:00'),('994c1a0d7d3a924898bc37f24efce452',4,2016,'NFL_20161002_SEA@NYJ','NYJ','SEA',0,0,'2016-10-02 13:00:00'),('996951eebc019cd1af7b68471d4c80d5',1,2016,'NFL_20160911_CIN@NYJ','NYJ','CIN',0,0,'2016-09-11 13:00:00'),('9a5df915a07c2357e9d2834bea4bd65d',11,2016,'NFL_20161120_CHI@NYG','NYG','CHI',0,0,'2016-11-20 13:00:00'),('9b3ab5a42f46295e77e7f614e26b6385',5,2016,'NFL_20161009_CIN@DAL','DAL','CIN',0,0,'2016-10-09 16:25:00'),('9b7f14febcedf68c746187e77507a327',8,2016,'NFL_20161027_JAC@TEN','TEN','JAC',0,0,'2016-10-27 20:25:00'),('9bfe080878fad2dcdcbc7b9d6bae2f71',8,2016,'NFL_20161030_OAK@TB','TB','OAK',0,0,'2016-10-30 13:00:00'),('9c1be2973bef946d6eb617a172fcb229',1,2016,'NFL_20160911_TB@ATL','ATL','TB',0,0,'2016-09-11 13:00:00'),('9c5c65410e1b9a30fcda78a49b3152f5',13,2016,'NFL_20161204_HOU@GB','GB','HOU',0,0,'2016-12-04 13:00:00'),('9d4bb277437e6f4547a87d6cee063d7f',4,2016,'NFL_20161002_BUF@NE','NE','BUF',0,0,'2016-10-02 13:00:00'),('9e4f9a551d35c424e23d5ce9f25ed15d',16,2016,'NFL_20161224_WAS@CHI','CHI','WAS',0,0,'2016-12-24 13:00:00'),('9f17e7ee4de72045ae0c735a1b484974',1,2016,'NFL_20160912_PIT@WAS','WAS','PIT',0,0,'2016-09-12 19:10:00'),('9f7b4eb184b2e361735cb86342f600e0',13,2016,'NFL_20161204_PHI@CIN','CIN','PHI',0,0,'2016-12-04 13:00:00'),('9fef28a8bf7381173bb3547f24be7cac',12,2016,'NFL_20161127_LAR@NO','NO','LAR',0,0,'2016-11-27 13:00:00'),('a18bf6d6ffed91a29dd9a010e63495ea',10,2016,'NFL_20161113_MIA@SD','SD','MIA',0,0,'2016-11-13 16:05:00'),('a2b7051eb08517e2168bff6dee353c85',3,2016,'NFL_20160925_CLE@MIA','MIA','CLE',0,0,'2016-09-25 13:00:00'),('a32fba6cf334d58f389d94f0501b8694',11,2016,'NFL_20161120_JAC@DET','DET','JAC',0,0,'2016-11-20 13:00:00'),('a401cb7e6ac0a9a1dbb4491deefc2402',15,2016,'NFL_20161218_NE@DEN','DEN','NE',0,0,'2016-12-18 16:25:00'),('a4430fe268d43f442b3356a45076fae0',3,2016,'NFL_20160925_WAS@NYG','NYG','WAS',0,0,'2016-09-25 13:00:00'),('a4b778d701c15b9a6d51ae76ad8d689e',9,2016,'NFL_20161106_CAR@LAR','LAR','CAR',0,0,'2016-11-06 16:05:00'),('a50cc470cd9c2825f64e281f69401e82',15,2016,'NFL_20161217_MIA@NYJ','NYJ','MIA',0,0,'2016-12-17 20:25:00'),('a598ea520d837888ce23200226a7b186',16,2016,'NFL_20161224_CIN@HOU','HOU','CIN',0,0,'2016-12-24 20:25:00'),('a655abddf6e1c2b32404f01e31ef73d4',7,2016,'NFL_20161023_MIN@PHI','PHI','MIN',0,0,'2016-10-23 13:00:00'),('ab55d3fa6b3674775164e6f3de1e6d76',9,2016,'NFL_20161106_TEN@SD','SD','TEN',0,0,'2016-11-06 16:25:00'),('aea9a28e1fac8cf8d214da687c783704',14,2016,'NFL_20161211_DEN@TEN','TEN','DEN',0,0,'2016-12-11 13:00:00'),('aec9149c2359e5cc8e37ea9ea78712db',12,2016,'NFL_20161127_ARI@ATL','ATL','ARI',0,0,'2016-11-27 13:00:00'),('b041603378f3aa2fe4b502553be68335',11,2016,'NFL_20161117_NO@CAR','CAR','NO',0,0,'2016-11-17 20:25:00'),('b099d10f9ab65080295c5e4039d25d75',10,2016,'NFL_20161113_LAR@NYJ','NYJ','LAR',0,0,'2016-11-13 13:00:00'),('b0f74317504ee063bf56456ff9e3623d',14,2016,'NFL_20161211_WAS@PHI','PHI','WAS',0,0,'2016-12-11 13:00:00'),('b12a214a179d18019950e67fd95ff19d',2,2016,'NFL_20160918_TB@ARI','ARI','TB',0,0,'2016-09-18 16:05:00'),('b214cefb98beb80903a0f2ae6d965d73',10,2016,'NFL_20161113_KC@CAR','CAR','KC',0,0,'2016-11-13 13:00:00'),('b3c4f84420095301d9f85e70d40f1337',7,2016,'NFL_20161023_WAS@DET','DET','WAS',0,0,'2016-10-23 13:00:00'),('b4777d7bbfc9c8a48ed6e8e50ee9826c',15,2016,'NFL_20161218_IND@MIN','MIN','IND',0,0,'2016-12-18 13:00:00'),('b5f2d274b4e8aa01f9d087675c4cfceb',12,2016,'NFL_20161127_NYG@CLE','CLE','NYG',0,0,'2016-11-27 13:00:00'),('b6895b39e171d48a7f0cbdb17cf551be',6,2016,'NFL_20161016_JAC@CHI','CHI','JAC',0,0,'2016-10-16 13:00:00'),('b6ff5b449204f39878800508cc0d7c06',2,2016,'NFL_20160918_CIN@PIT','PIT','CIN',0,0,'2016-09-18 13:00:00'),('b712b7f99bd6e495db163d1b6c1ef642',2,2016,'NFL_20160918_SF@CAR','CAR','SF',0,0,'2016-09-18 13:00:00'),('b7a42cdb0e606e232281152c7a24af21',11,2016,'NFL_20161120_PIT@CLE','CLE','PIT',0,0,'2016-11-20 13:00:00'),('bc4942be404159a9c7b671d000041470',4,2016,'NFL_20161002_CAR@ATL','ATL','CAR',0,0,'2016-10-02 13:00:00'),('bc6149f613916df05d955bf0509b1c75',17,2016,'NFL_20170101_NYG@WAS','WAS','NYG',0,0,'2017-01-01 13:00:00'),('befd2aeb72aa8a81836394c70d90f0d5',12,2016,'NFL_20161127_NE@NYJ','NYJ','NE',0,0,'2016-11-27 20:30:00'),('bf3eaf20e55cebb106e53a226a48dc6f',17,2016,'NFL_20170101_OAK@DEN','DEN','OAK',0,0,'2017-01-01 16:25:00'),('bf4dd5722bbd70f46abf81ac6345766c',8,2016,'NFL_20161030_NE@BUF','BUF','NE',0,0,'2016-10-30 13:00:00'),('c1a8374a1f787577841b469ec758330b',11,2016,'NFL_20161120_NE@SF','SF','NE',0,0,'2016-11-20 16:25:00'),('c1ceb45c69d10bf0caeae726a7d850dd',2,2016,'NFL_20160915_NYJ@BUF','BUF','NYJ',0,0,'2016-09-15 20:25:00'),('c309768480b745dabcbb23eb6c54286b',9,2016,'NFL_20161106_PHI@NYG','NYG','PHI',0,0,'2016-11-06 13:00:00'),('c44771efbb8073d5f98c92d714191174',14,2016,'NFL_20161212_BAL@NE','NE','BAL',0,0,'2016-12-12 20:30:00'),('c543a649daf3fb1d48c697227d3a4b08',16,2016,'NFL_20161224_TB@NO','NO','TB',0,0,'2016-12-24 13:00:00'),('c5b084f6c9f5b6499dcaa092a5c22550',14,2016,'NFL_20161211_ARI@MIA','MIA','ARI',0,0,'2016-12-11 13:00:00'),('c77233b1dc8dfb9f702183eb493621e3',14,2016,'NFL_20161208_OAK@KC','KC','OAK',0,0,'2016-12-08 20:25:00'),('c83390deeb065d21a9d67c6cde4b96dd',6,2016,'NFL_20161016_KC@OAK','OAK','KC',0,0,'2016-10-16 16:05:00'),('cb9de7162a70fbb90fdec2c221ab69d1',2,2016,'NFL_20160918_NO@NYG','NYG','NO',0,0,'2016-09-18 13:00:00'),('cc818fae7766dde27e6a1c40eabad545',4,2016,'NFL_20161002_NO@SD','SD','NO',0,0,'2016-10-02 16:25:00'),('cc9fae73d5146818897744be2920e8a2',12,2016,'NFL_20161127_SEA@TB','TB','SEA',0,0,'2016-11-27 16:05:00'),('cce13e015e84294a376568bd4ea012a7',8,2016,'NFL_20161030_PHI@DAL','DAL','PHI',0,0,'2016-10-30 20:30:00'),('cde7fe5fc668666e9a7029486d27835e',16,2016,'NFL_20161224_NYJ@NE','NE','NYJ',0,0,'2016-12-24 13:00:00'),('cf045e676f768660da730943d41aa674',4,2016,'NFL_20161002_DEN@TB','TB','DEN',0,0,'2016-10-02 16:05:00'),('cf8fb3e10dbf6cb917f71548d9c26da9',2,2016,'NFL_20160918_BAL@CLE','CLE','BAL',0,0,'2016-09-18 13:00:00'),('cf9826ea4c90814ab2529ca88c2d7358',13,2016,'NFL_20161204_SF@CHI','CHI','SF',0,0,'2016-12-04 13:00:00'),('cfcc71ae73e961296518d2c5aef0f637',4,2016,'NFL_20161002_DAL@SF','SF','DAL',0,0,'2016-10-02 16:25:00'),('d02aaf1f77f594acf7ddf80695f181ed',2,2016,'NFL_20160918_GB@MIN','MIN','GB',0,0,'2016-09-18 20:30:00'),('d04b44193221adfcfa17665c9ffca46f',8,2016,'NFL_20161030_SEA@NO','NO','SEA',0,0,'2016-10-30 13:00:00'),('d0c177db839e3f1f30fb8aea022836ac',16,2016,'NFL_20161224_ATL@CAR','CAR','ATL',0,0,'2016-12-24 13:00:00'),('d5a407dbb530d045b895e7f2130cf8a8',3,2016,'NFL_20160925_LAR@TB','TB','LAR',0,0,'2016-09-25 16:05:00'),('d6e0da2a6521fa3c1d3241024a426e3f',8,2016,'NFL_20161030_DET@HOU','HOU','DET',0,0,'2016-10-30 13:00:00'),('d730201d5d2db302e3995b01ffa269f2',5,2016,'NFL_20161009_NYG@GB','GB','NYG',0,0,'2016-10-09 20:30:00'),('d7b683c0b60f6f7e53fef81f84402056',1,2016,'NFL_20160911_GB@JAC','JAC','GB',0,0,'2016-09-11 13:00:00'),('d835185d2eeeb715edc7764f90a4504e',5,2016,'NFL_20161009_ATL@DEN','DEN','ATL',0,0,'2016-10-09 16:05:00'),('d908dafea17384ab5732dfc6a2f9eaa1',7,2016,'NFL_20161023_SEA@ARI','ARI','SEA',0,0,'2016-10-23 20:30:00'),('dd10113242729169e5e852b5012de83f',9,2016,'NFL_20161103_ATL@TB','TB','ATL',0,0,'2016-11-03 20:25:00'),('de6965c3e9158ed0b616812ccfa250fc',11,2016,'NFL_20161120_BAL@DAL','DAL','BAL',0,0,'2016-11-20 13:00:00'),('ded2a40560eee535017d21d51515f72d',5,2016,'NFL_20161009_WAS@BAL','BAL','WAS',0,0,'2016-10-09 13:00:00'),('df71b1cb40f35ebd564f7711ef00864f',12,2016,'NFL_20161124_PIT@IND','IND','PIT',0,0,'2016-11-24 20:30:00'),('e1e3494526514287e92bd183f134c81b',12,2016,'NFL_20161124_MIN@DET','DET','MIN',0,0,'2016-11-24 12:30:00'),('e2d2d85fd0a004073e55f0c1d63861e5',9,2016,'NFL_20161106_IND@GB','GB','IND',0,0,'2016-11-06 16:25:00'),('e3158e21a2712daeb41736d81ea31960',9,2016,'NFL_20161106_DAL@CLE','CLE','DAL',0,0,'2016-11-06 13:00:00'),('e3516a326eb3508aa7af8181c51b0a55',6,2016,'NFL_20161016_LAR@DET','DET','LAR',0,0,'2016-10-16 13:00:00'),('e414eabc29f8c718bb291ae48955fd36',14,2016,'NFL_20161211_ATL@LAR','LAR','ATL',0,0,'2016-12-11 16:25:00'),('e612b1ba84b4a3caf3fbc5d504006542',17,2016,'NFL_20170101_BAL@CIN','CIN','BAL',0,0,'2017-01-01 13:00:00'),('e62c26ccc53f404b8d8ebe27e1d7f01d',14,2016,'NFL_20161211_PIT@BUF','BUF','PIT',0,0,'2016-12-11 13:00:00'),('e701b45e23032cd2f04600ccd6c7c669',13,2016,'NFL_20161204_TB@SD','SD','TB',0,0,'2016-12-04 16:25:00'),('e7d6d41f332b0aef1d29bb7473b5403d',9,2016,'NFL_20161106_JAC@KC','KC','JAC',0,0,'2016-11-06 13:00:00'),('e9e5c56cdc1563d07370ba38f9a2103f',11,2016,'NFL_20161120_PHI@SEA','SEA','PHI',0,0,'2016-11-20 16:25:00'),('ea5595008e0d4e05bf5984e0b9da9092',1,2016,'NFL_20160911_CHI@HOU','HOU','CHI',0,0,'2016-09-11 13:00:00'),('eba7204d5f66b76f944793a43d78a26e',16,2016,'NFL_20161224_ARI@SEA','SEA','ARI',0,0,'2016-12-24 16:25:00'),('ef5ea923c11dbb7eb3ba2fba05d08435',10,2016,'NFL_20161110_CLE@BAL','BAL','CLE',0,0,'2016-11-10 20:25:00'),('ef940b366486d7ed90e8d0ad0e9d1b73',7,2016,'NFL_20161024_HOU@DEN','DEN','HOU',0,0,'2016-10-24 20:30:00'),('f3377b272567d704cb684f3d7cea7543',3,2016,'NFL_20160925_DET@GB','GB','DET',0,0,'2016-09-25 13:00:00'),('f40c4fc0e1e53d325ed30a1522fd53ea',14,2016,'NFL_20161211_NO@TB','TB','NO',0,0,'2016-12-11 13:00:00'),('f459cf05f3cdec1a1d3aae5c09dacfef',7,2016,'NFL_20161023_BAL@NYJ','NYJ','BAL',0,0,'2016-10-23 13:00:00'),('f473ecf7579116264014fbbaf3e7de7d',13,2016,'NFL_20161204_NYG@PIT','PIT','NYG',0,0,'2016-12-04 16:25:00'),('f631c976b3a58d5f68f3c9bf00d02209',1,2016,'NFL_20160911_OAK@NO','NO','OAK',0,0,'2016-09-11 13:00:00'),('f897b2408fedc5c4dacc0b5a25208e39',11,2016,'NFL_20161120_MIA@LAR','LAR','MIA',0,0,'2016-11-20 16:05:00'),('f8f75678c5e7af9ac89f1e22898dc94a',1,2016,'NFL_20160911_MIA@SEA','SEA','MIA',0,0,'2016-09-11 16:05:00'),('f9ae327551806a183c63a76a5e26fa9c',17,2016,'NFL_20170101_ARI@LAR','LAR','ARI',0,0,'2017-01-01 16:25:00'),('fa699face7bfda3949c28afb4e96dc8b',13,2016,'NFL_20161204_KC@ATL','ATL','KC',0,0,'2016-12-04 13:00:00'),('fd6c1d48699db7bae420f777dc921ccc',16,2016,'NFL_20161225_DEN@KC','KC','DEN',0,0,'2016-12-25 20:30:00'),('ff271366fce96dc9b49643cec2ae31c5',6,2016,'NFL_20161016_BAL@NYG','NYG','BAL',0,0,'2016-10-16 13:00:00');
/*!40000 ALTER TABLE `nfl_schedule` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nfl_schedule_GUID` BEFORE INSERT ON `nfl_schedule`
 FOR EACH ROW begin
 SET new.gameId := (select md5(UUID()));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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

-- Dump completed on 2016-09-12  9:03:44
