-- MySQL dump 10.13  Distrib 5.6.27, for osx10.8 (x86_64)
--
-- Host: localhost    Database: ff
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-08  7:59:36
