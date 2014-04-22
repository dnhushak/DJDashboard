CREATE DATABASE  IF NOT EXISTS `db30919` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db30919`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: mysql.cs.iastate.edu    Database: db30919
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `rotation`
--

DROP TABLE IF EXISTS `rotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rotation` (
  `idrotation` bigint(20) NOT NULL AUTO_INCREMENT,
  `physicalReceived` bit(1) DEFAULT NULL,
  `digitalReceived` bit(1) DEFAULT NULL,
  `physicalReceivedDate` datetime DEFAULT NULL,
  `digitalReceivedDate` datetime DEFAULT NULL,
  `stationPriority` int(11) DEFAULT NULL,
  `iddistributor` int(11) DEFAULT NULL,
  `idalbum` bigint(20) DEFAULT NULL,
  `karmaPromoter` int(11) DEFAULT NULL,
  `karmaMusicDirector` int(11) DEFAULT NULL,
  `karmaReviewer` int(11) DEFAULT NULL,
  `scorePromoter` int(11) DEFAULT NULL,
  `scoreMusicDirector` int(11) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL COMMENT 'ID of user assigned to review album',
  `ignoreInChart` bit(1) DEFAULT NULL,
  `cmjAdds` int(11) DEFAULT NULL COMMENT 'Total number of adds for an album during its CMJ add week.',
  `cmjCurrent` int(11) DEFAULT NULL COMMENT 'Current position on the CMJ Chart',
  `cmjPeak` int(11) DEFAULT NULL COMMENT 'Highest position on the CMJ chart in this release''s history',
  `cmjPeakDate` datetime DEFAULT NULL COMMENT 'The date of the CMJ chart peak for this release.',
  `cmjAddDate` datetime DEFAULT NULL,
  `commentsMusicDirector` varchar(1000) DEFAULT NULL,
  `commentsReviewer` varchar(1000) DEFAULT NULL,
  `reviewDate` datetime DEFAULT NULL,
  PRIMARY KEY (`idrotation`),
  KEY `IDDISTRIBUTER_idx` (`iddistributor`),
  KEY `IDALBUMCMJ_idx` (`idalbum`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:16
