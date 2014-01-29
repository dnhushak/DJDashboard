CREATE DATABASE  IF NOT EXISTS `db30919` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db30919`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: mysql.cs.iastate.edu    Database: db30919
-- ------------------------------------------------------
-- Server version	5.1.71

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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `idalbum` bigint(20) NOT NULL AUTO_INCREMENT,
  `idartist` bigint(20) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`idalbum`),
  KEY `IDALBUMARTIST_idx` (`idartist`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `idartist` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`idartist`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grant`
--

DROP TABLE IF EXISTS `grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grant` (
  `idgrant` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `playcount` int(11) DEFAULT NULL,
  PRIMARY KEY (`idgrant`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onairsession`
--

DROP TABLE IF EXISTS `onairsession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `onairsession` (
  `idonairsession` bigint(20) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) DEFAULT NULL,
  `logon` datetime DEFAULT NULL,
  `logoff` datetime DEFAULT NULL,
  PRIMARY KEY (`idonairsession`),
  KEY `IDONAIRUSER_idx` (`iduser`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playgrant`
--

DROP TABLE IF EXISTS `playgrant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playgrant` (
  `idplaygrant` bigint(20) NOT NULL AUTO_INCREMENT,
  `idgrant` bigint(20) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL,
  `idonairsession` bigint(20) DEFAULT NULL,
  `playdate` datetime DEFAULT NULL,
  PRIMARY KEY (`idplaygrant`),
  KEY `IDPLAYGRANTUSER_idx` (`iduser`),
  KEY `IDPLAYGRANTUSERONAIR_idx` (`idonairsession`),
  KEY `IDPLAYGRANTGRANT_idx` (`idgrant`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playtrack`
--

DROP TABLE IF EXISTS `playtrack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playtrack` (
  `idplaytrack` bigint(20) NOT NULL AUTO_INCREMENT,
  `idtrack` bigint(20) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL,
  `idonairsession` bigint(20) DEFAULT NULL,
  `playdate` datetime DEFAULT NULL,
  PRIMARY KEY (`idplaytrack`),
  KEY `IDPLAYTRACKTRACK_idx` (`idtrack`),
  KEY `IDPLAYTRACKUSER_idx` (`iduser`),
  KEY `IDPLAYTRACKONAIRSESSION_idx` (`idonairsession`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `psa`
--

DROP TABLE IF EXISTS `psa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `psa` (
  `idpsa` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `playcount` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpsa`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `track` (
  `idtrack` bigint(20) NOT NULL AUTO_INCREMENT,
  `idalbum` bigint(20) DEFAULT NULL,
  `idartist` bigint(20) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `ReleaseDate` date DEFAULT NULL,
  `FCC` bit(1) DEFAULT NULL,
  `Recommended` bit(1) DEFAULT NULL,
  `ITLID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idtrack`),
  KEY `IDTRACKALBUM_idx` (`idalbum`),
  KEY `IDTRACKARTIST_idx` (`idartist`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `idusertype` int(11) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `passwordhash` varchar(255) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `idlastlogon` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`iduser`),
  KEY `IDUSERUSERTYPE_idx` (`idusertype`),
  KEY `IDUSERLASTLOGON_idx` (`idlastlogon`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersession`
--

DROP TABLE IF EXISTS `usersession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usersession` (
  `idusersession` bigint(20) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) DEFAULT NULL,
  `logon` datetime DEFAULT NULL,
  `logoff` datetime DEFAULT NULL,
  PRIMARY KEY (`idusersession`),
  KEY `IDUSERSESSION_idx` (`iduser`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertype` (
  `idusertype` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) DEFAULT NULL,
  `isAdmin` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idusertype`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'db30919'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-01-28  9:44:21
