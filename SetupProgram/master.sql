CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `idalbum` bigint(20) NOT NULL AUTO_INCREMENT,
  `idartist` bigint(20) DEFAULT NULL,
  `Name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Priority` int(11) DEFAULT NULL,
  `idprimarygenre` int(11) DEFAULT NULL,
  `idsecondarygenre` int(11) DEFAULT NULL,
  PRIMARY KEY (`idalbum`),
  KEY `IDALBUMARTIST_idx` (`idartist`),
  KEY `IDPRIMARYGENREGENRE_idx` (`idprimarygenre`),
  KEY `IDSECONDARYGENRE_idx` (`idsecondarygenre`)
) ENGINE=InnoDB AUTO_INCREMENT=3206 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `idartist` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idartist`)
) ENGINE=MyISAM AUTO_INCREMENT=2189 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:17
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `distributor`
--

DROP TABLE IF EXISTS `distributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distributor` (
  `iddistributor` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(1000) DEFAULT NULL,
  `contactName` varchar(255) DEFAULT NULL,
  `location` varchar(1000) DEFAULT NULL,
  `affiliated` varchar(1000) DEFAULT NULL,
  `website` varchar(1000) DEFAULT NULL,
  `digitalDownload` varchar(1000) DEFAULT NULL,
  `weight` int(11) DEFAULT '0',
  PRIMARY KEY (`iddistributor`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:17
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `errorlog`
--

DROP TABLE IF EXISTS `errorlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errorlog` (
  `iderrorlog` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) DEFAULT NULL,
  `message` varchar(5000) DEFAULT NULL,
  `stacktrace` varchar(1024) DEFAULT NULL,
  `logdate` datetime DEFAULT NULL,
  `ipaddress` varchar(50) DEFAULT NULL,
  `browserinfo` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`iderrorlog`),
  KEY `IDERRORLOGUSER_idx` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:18
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `exceptionlog`
--

DROP TABLE IF EXISTS `exceptionlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exceptionlog` (
  `idexceptionlog` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` varchar(2048) DEFAULT NULL,
  `stacktrace` varchar(6000) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL,
  `ipaddress` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idexceptionlog`),
  KEY `IDEXCEPTIONUSER_idx` (`iduser`)
) ENGINE=MyISAM AUTO_INCREMENT=251027 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:14
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `idgenre` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idgenre`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:14
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `grant`
--

DROP TABLE IF EXISTS `grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grant` (
  `idgrant` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `message` varchar(2048) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `playcount` int(11) DEFAULT NULL,
  `maxplaycount` int(11) DEFAULT NULL,
  `modifieduser` int(11) DEFAULT NULL,
  PRIMARY KEY (`idgrant`),
  KEY `IDGRANTUSER_idx` (`modifieduser`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:18
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
) ENGINE=MyISAM AUTO_INCREMENT=179 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:17
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `playabletypes`
--

DROP TABLE IF EXISTS `playabletypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playabletypes` (
  `idplayabletypes` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idplayabletypes`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:15
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:17
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist` (
  `idplaylist` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) DEFAULT NULL,
  `tracks` varchar(10000) DEFAULT 'null' COMMENT 'Comma delimited list of idtracks, each of which will be foreign keyed to the track table.',
  `createdate` datetime DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idplaylist`),
  KEY `IDPLAYLISTUSER_idx` (`iduser`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:17
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `playpsa`
--

DROP TABLE IF EXISTS `playpsa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playpsa` (
  `idplaypsa` bigint(20) NOT NULL AUTO_INCREMENT,
  `idpsa` bigint(20) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL,
  `idonairsession` bigint(20) DEFAULT NULL,
  `playdate` datetime DEFAULT NULL,
  PRIMARY KEY (`idplaypsa`),
  KEY `IDPLAYPSAUSER_idx` (`iduser`),
  KEY `IDPLAYPSAPSA_idx` (`idpsa`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:15
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
) ENGINE=MyISAM AUTO_INCREMENT=283 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:14
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `psa`
--

DROP TABLE IF EXISTS `psa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `psa` (
  `idpsa` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `message` varchar(2048) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `playcount` int(11) DEFAULT NULL,
  `maxplaycount` int(11) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL,
  `sponsor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpsa`),
  KEY `PSAUSERID_idx` (`iduser`),
  CONSTRAINT `PSAUSERID` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:14
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Dumping routines for database 'kure'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddDistributor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `AddDistributor`(
	aDistributorName varchar(255),
	aPhone varchar(20),
	aEmail varchar (1000),
	aContactName varchar (255),
	aLocation varchar(1000),
	aAffiliated varchar(1000),
	aWebsite varchar(1000),
	aDownload varchar (1000),
	aWeight int(11))
BEGIN


#First Check for exisiting distributor
	SET @DistributorID = (SELECT d.iddistributor FROM kure.distributor d
		WHERE d.name = aDistributorName);
	IF(@DistributorID IS NOT NULL) THEN
		#If it exists, then updated it
		UPDATE kure.distributor
		SET
			name = aDistributorName,
			phone = aPhone,
			email = aEmail,
			contactName = aContactName,
			location = aLocation,
			affiliated = aAffiliated,
			website = aWebsite,
			digitalDownload = aDownload,
			weight = aWeight
		WHERE iddistributor = @DistributorID;
	ELSE
	#Else create new
		INSERT INTO kure.distributor
			(name,
			phone,
			email,
			contactName,
			location,
			affiliated,
			website,
			digitalDownload,
			weight)
		VALUES
			(
			aDistributorName,
			aPhone,
			aEmail,
			aContactName,
			aLocation,
			aAffiliated,
			aWebsite,
			aDownload,
			aWeight);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddGrant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `AddGrant`(
	aGrantName varchar(45),
	aGrantMessage varchar(2048),
	aEndDate datetime,
	aMaxPlayCount int
)
BEGIN
-- --------------------------------
-- AddGrant
-- Created by Robert Clabough 2/13/2014
--
-- Adds a grant to the 'grant' table for auto population in playlists
--
-- PARAMETERS
--   aGrantName - Name of the grant 'Pizza Shack'
--   aGrantMessage - What the dj should say on the air, or mention about ( free form )
--   aEndDate - Date this grant should be taken out of rotation
-- --------------------------------



	#First check to see if the grant name is in the table
	SET @GrantID = (SELECT g.idgrant FROM kure.grant g
		WHERE g.name = aGrantName);
	IF(@GrantID IS NOT NULL) THEN
		#Check if it is enddated
		SET @prevEndDate = (SELECT g.enddate FROM kure.grant g
			WHERE g.idgrant = @GrantID);
		IF(@prevEndDate IS NOT NULL) THEN
			UPDATE kure.grant
				SET enddate = null;
		ELSE	
			UPDATE kure.grant
				SET enddate = null, message = aGrantMessage, name = aGrantName WHERE idgrant = @GrantID;
		END IF;
	ELSE
		INSERT INTO kure.grant(name, message, startdate, enddate, playcount, maxplaycount)
			VALUES(aGrantName, aGrantMessage, current_timestamp, aEndDate, 0, aMaxPlayCount);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddPSA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `AddPSA`(
	aPSAID bigint,
	aName varchar(45),
	aMessage varchar(2048),
	aEndDate datetime,

	aSponsor varchar(45),
	aPlayCount int,
	aMaxPlayCount int,
	aUserID int
)
BEGIN
	IF(aPSAID = 0) THEN
	BEGIN
		INSERT INTO psa(name, message, createdate, enddate, playcount, iduser, sponsor, maxplaycount)
		VALUES(aName, aMessage, current_timestamp(), aEndDate, 0, aUserID, aSponsor, aMaxPlayCount);

	#Return the new ID
	SELECT @@IDENTITY as 'ID';
	END;
	else
	BEGIN
		UPDATE psa
		SET name = aName, message = aMessage, enddate = aEndDate, sponsor = aSponsor, playcount = aPlayCount,
			maxplaycount = aMaxPlayCount, iduser = aUserID
		WHERE idpsa = aPSAID;
	END;
	SELECT aPSAID as 'ID';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddRotation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `AddRotation`(
	aPhysicalReceived BIT(1),
	aDigitalReceived BIT(1),
	aPhysicalReceivedDate DATETIME,
	aDigitalReceivedDate DATETIME,
	aStationPriority INT(11),
	aDistributorID INT(11),
	aAlbumID BIGINT(20),
	aKarmaPromoter INT(11),
	aKarmaMusicDirector INT(11),
	aScorePromoter INT(11),
	aScoreMusicDirector INT(11),
	aReviewerID INT(11),
	aIgnoreInChart BIT(1),
	aCMJAdds INT(11),
	aCMJAddDate DATETIME,
	aCMJCurrent INT(11),
	aCMJPeak INT(11),
	aCMJPeakDate DATETIME,
	aCommentsMusicDirector VARCHAR(1000))
BEGIN

	SET @RotationID = (SELECT rot.idrotation FROM rotation rot WHERE rot.idalbum = aAlbumID);
	
	IF (@RotationID IS NOT NULL) THEN
		UPDATE rotation
		SET
			physicalReceived = aPhysicalReceived,
			digitalReceived = aDigitalReceived,
			physicalReceivedDate = aPhysicalReceivedDate,
			digitalReceivedDate = aDigitalReceivedDate,
			stationPriority = aStationPriority,
			iddistributor = aDistributorID,
			idalbum = aAlbumID,
			karmaPromoter = aKarmaPromoter,
			karmaMusicDirector = aKarmaMusicDirector,
			scorePromoter = aScorePromoter,
			scoreMusicDirector = aScoreMusicDirector,
			iduser = aReviewerID,
			ignoreInChart = aIgnoreInChart,
			cmjAdds = aCMJAdds,
			cmjCurrent = aCMJCurrent,
			cmjPeak = aCMJPeak,
			cmjPeakDate = aCMJPeakDate,
			cmjAddDate = aCMJAddDate,
			commentsMusicDirector = aCommentsMusicDirector
		WHERE idrotation = @RotationID;

	ELSE
		INSERT INTO rotation
			(physicalReceived,
			digitalReceived,
			physicalReceivedDate,
			digitalReceivedDate,
			stationPriority,
			iddistributor,
			idalbum,
			karmaPromoter,
			karmaMusicDirector,
			scorePromoter,
			scoreMusicDirector,
			iduser,
			ignoreInChart,
			cmjAdds,
			cmjCurrent,
			cmjPeak,
			cmjPeakDate,
			cmjAddDate,
			commentsMusicDirector)
		VALUES
			(aPhysicalReceived,
			aDigitalReceived,
			aPhysicalReceivedDate,
			aDigitalReceivedDate,
			aStationPriority,
			aDistributorID,
			aAlbumID,
			aKarmaPromoter,
			aKarmaMusicDirector,
			aScorePromoter,
			aScoreMusicDirector,
			aReviewerID,
			aIgnoreInChart,
			aCmjAdds,
			aCmjCurrent,
			aCmjPeak,
			aCmjPeakDate,
			aCmjAddDate,
			aCommentsMusicDirector);
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addTrack` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `addTrack`(
	CalledName varchar(250),
	CalledArtist varchar(250),
	CalledAlbum varchar(250),
	CalledPlayCount int,
	FCCFlag bit,
	CalledRecommended bit,
	ITunesID int,
	CalledReleaseDate date,
	CalledEndDate datetime,
	aPrimaryGenre int,
	aSecondaryGenre int,
	FilePath varchar(1023),
	aSubSonicID bigint
)
BEGIN
-- -----------------------------------
-- AddTrack
--  Created by Robert Clabough
--  Created 1/?/2014
--  Modified 2/14/2014 - rclabough
--  Modified 2/21/2014
--  	Removed inserts into genre table
--  Modified 3/26/2014
--  	Added subsonic ID to parameters / inserts / updates
--
--  Used to Add a track from the database given required information.
--  If track is already in the database, it updates the information to new provided info
--  All tracks are sensitive to ASCII characters, so if spelling is off of even one item,
--  a new item will be created.
--
--  PARAMETERS
--    CalledName - Name of the track
--    CalledArtist - Name of the artist
--    CalledAlbum - Name of the album
--    CalledPlayCount - How many plays this track already has (if unsure, set to 0)
--    FCCFlag - If this is explicit, 1 if yes, 0 if no
--    CalledRecommended - If this song is a recommended song, 1 if yes, 0 if no
--    ITunesID - ID from itunes library xml, may be fully implemented later
--    CalledReleaseDate - Date this song was officially released
--    CalledEndDate - Date this song is taken out of rotation (NOT DELETED)
--    aPrimaryGenre - Primary Genre of song (e.g. 'Rock' or 'Classic Rock')
--    aSecondaryGenre - Secondary Genre of song
--    FilePath - UTF filepath to song on local machines (used for copying later)
-- -----------------------------------



	#GENRE
	#Find GenreID, if it doesn't exist, then add it.

	#PRIMARY GENRE
	IF(aPrimaryGenre IS NOT NULL) THEN
		SET @PrimaryGenreID = aPrimaryGenre;
			#(SELECT idGenre FROM kure.genre WHERE Name = aPrimaryGenre limit 1);
			#IF(@PrimaryGenreID IS NULL) THEN
			#INSERT INTO genre(Name) Values(aPrimaryGenre);
			#SET @PrimaryGenreID = @@IDENTITY;
			#END IF;
	ELSE
		SET @PrimaryGenreID = null;
	END IF;

	#SECONDARY GENRE
	IF(aSecondaryGenre IS NOT NULL) THEN
		SET @SecondaryGenreID = aSecondaryGenre;
			#(SELECT idGenre FROM kure.genre WHERE Name = aSecondaryGenre limit 1);
			#IF(@SecondaryGerneID IS NULL) THEN
			#INSERT INTO genre(Name) Values(aSecondaryGenre);
			#SET @SecondaryGenreID = @@IDENTITY;
			#END IF;
	ELSE
		SET @SecondaryGenreID = null;
	END IF;

		#Fetch ArtistID, Add artist if not found
	SET @ArtistID = (SELECT art.idArtist FROM artist art WHERE art.Name = CalledArtist);
	IF(@ArtistID IS NULL) then
		INSERT INTO artist(Name) VALUES(CalledArtist);
		SET @ArtistID = @@IDENTITY;
	END IF;

	SET @AlbumID = (SELECT alb.idalbum FROM album alb WHERE alb.Name = CalledAlbum AND alb.idArtist = @ArtistID);
	IF(@AlbumID IS NULL) THEN
		INSERT INTO album(Name, idArtist, idprimarygenre, idsecondarygenre) Values(CalledAlbum, @ArtistID, @PrimaryGenreID, @SecondaryGenreID);
		SET @AlbumID = @@IDENTITY;
	END IF;


	#Add the track based on ArtistID and AlbumID
	#Variables: CalledName, CalledArtist, CalledAlbum, CalledPlayCount, FCCFlag, Recommended, ITunesID, ReleaseDate, EndDate (Some can be null)
	SET @TrackID = (SELECT trk.idTrack FROM track trk WHERE trk.idArtist = @ArtistID AND trk.idAlbum = @AlbumID AND Name = CalledName);
	IF(@TrackID IS NULL) then
		INSERT INTO track(Name, idAlbum, idArtist, PlayCount, CreateDate, FCC, Recommended, ITLID, ReleaseDate, EndDate, Path, idPrimaryGenre, idSecondaryGenre, idsubsonic) 
		Values(CalledName, @AlbumID, @ArtistID, CalledPlayCount, current_timestamp, FCCFlag, CalledRecommended, ITunesID, CalledReleaseDate, CalledEndDate, FilePath, @PrimaryGenre, @SecondaryGenre, aSubSonicID);
		SET @TrackID = @@IDENTITY;
	ELSE
		#If there is a track, update it be what I want
		UPDATE kure.track
		SET Name = CalledName, CreateDate = current_timestamp, EndDate = CalledEndDate, ReleaseDate = CalledReleaseDate,
			FCC = FCCFlag, Recommended = CalledRecommended, ITLID = ITunesID, Path = FilePath, idPrimaryGenre = @PrimaryGenreID, 
			idSecondaryGenre = @SecondaryGenreID, idsubsonic = aSubSonicID
		WHERE idtrack = @TrackID;
	END IF;
	SELECT @TrackID as 'ID';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `AddUser`(
	aUserName varchar(45),
	aPasswordHash varchar(1024),
	aSalt varchar(32),
	aEndDate DateTime,
	aFirstName varchar(45),
	aLastName varchar(45),
	aUserTypeID int,
	aEmail varchar(500)
)
begin
-- ----------------------------------------------------------------------------------
--  Created by Robert Clabough
--  2/18/2014
--  Stored Procedure to add a user
-- ----------------------------------------------------------------------------------

	#First find if there is a valid username
	SET @UserID = (SELECT iduser FROM user WHERE username = aUserName);
	IF(@UserID IS NOT NULL) THEN 
		SELECT 1 as 'Error';
	ELSE
		INSERT INTO user(idusertype, username, salt, passwordhash, startdate, enddate, idlastlogon, firstname, lastname, email)
			VALUES(aUserTypeID, aUserName, aSalt, aPasswordHash, current_timestamp(), aEndDate, null, aFirstName, aLastName, aEmail);
		SELECT 0 as 'Error';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddUserType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `AddUserType`(
	aUserTypeName varchar(255),
	aLibraryView bit,
	aLibraryManage bit,
	aPSAView bit,
	aPSAEdit bit,
	aGrantView bit,
	aGrantEdit bit,
	aManageUsers bit,
	aEditPermissions bit,
	aEditUserType bit,
	aOnAirSignon bit,
	aReviewMusic bit
)
BEGIN
	SET @usertypeID = (SELECT idUserType FROM kure.usertype 
		where LibraryView = aLibraryView
		AND LibraryManage = aLibraryManage
		AND PSAView = aPSAView
		AND PSAEdit = aPSAEdit
		AND GrantView = aGrantView
		AND GrantEdit = aGrantEdit
		AND ManageUsers = aManageUsers
		AND EditPermissions = aEditPermissions
		AND EditUserType = aEditUserType
		AND OnAirSignon = aOnAirSignon 
		AND ReviewMusic = aReviewMusic);

	#usertypeID should be null, if it is not then there is already a usertype with those permissions

	IF(@usertypeID IS NOT NULL) THEN
		SELECT @usertypeID as 'Type ID', 1 as 'Duplicate';
	ELSE 
		INSERT INTO kure.usertype(typename, LibraryView, LibraryManage, PSAView, PSAEdit, GrantView, GrantEdit, ManageUsers, PlaylistEditor, EditPermissions, OnAirSignon, ReviewMusic)
			VALUES(aUserTypeName, aLibraryView, aLibraryManage, aPSAView, aPSAEdit, aGrantView, aGrantEdit, aManageUsers, 1, aEditPermissions, aOnAirSignon, aReviewMusic);
		SELECT @@IDENTITY as 'Type ID', 0 as 'Duplicate';

	END IF;
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AssignReveiwer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `AssignReveiwer`(
	aRotationID INT(11),
	aReviewerID INT(11))
BEGIN
	UPDATE rotation
		SET
			iduser = aReviewerID
		WHERE idrotation = aRotationID;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeletePlaytrack` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `DeletePlaytrack`(
	aPlayID bigint,
	aUserID int
)
BEGIN
	SET @CorrectUser = (SELECT iduser FROM playtrack WHERE idplaytrack = aPlayID);
	IF(aUserID = @CorrectUser)
	THEN
		UPDATE playtrack SET idonairsession = null, playdate = null, idtrack = null
			WHERE idplaytrack = aPlayID;
		CALL LogError(aUserID, 'Deleted an existing play', 'Delete Playtrack Stored Procedure');
	ELSE
		CALL LogError(aUserID, 'Incorrect user tried to delete a play row','DeletePlaytrack Stored Procedure');
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `DeleteUser`(
	aUserID bigint
)
BEGIN
	UPDATE user 
	SET enddate = now() 
	WHERE iduser = aUserID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EndUserSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `EndUserSession`(
	aSessionID bigint
)
BEGIN
#Ends a current user session
	UPDATE usersession SET logoff = current_timestamp() WHERE idusersession = aSessionID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlbumList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAlbumList`()
BEGIN
	SELECT alb.idalbum as 'ID', alb.Name as 'Album Name', pGenre.Name as 'PrimaryGenre', sGenre.Name as 'SecondaryGenre'
	FROM album alb
	LEFT OUTER JOIN genre pGenre ON alb.idprimarygenre = pGenre.idgenre
	LEFT OUTER JOIN genre sGenre ON alb.idsecondarygenre = sGenre.idgenre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlbumPlaysByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAlbumPlaysByID`(
	aAlbumID bigint
)
BEGIN
	SELECT
		trk.idtrack as 'TrackID',
		alb.idalbum as 'AlbumID',
		u.UserName as 'UserName',
		trk.name as 'TrackName',
		ptrk.playdate as 'PlayDate'
	FROM track trk
	INNER JOIN album alb ON trk.idalbum = alb.idalbum
	INNER JOIN playtrack ptrk ON trk.idtrack = ptrk.idtrack
	INNER JOIN user u ON ptrk.iduser = u.iduser
	WHERE alb.idalbum = aAlbumID;
		

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlbumsAutoComplete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAlbumsAutoComplete`(
	aAlbumName varchar(20)
)
BEGIN
-- ------------------------------------------
--  GetTracksLike
--  Builds a list of tracks where the name is like
--  'something' which is just some characters.
--  This is coupled with GetArtistWHhereTracksLike and GetAlbumsWhereTrackLike
--
-- ------------------------------------------
	SELECT idAlbum, Name
	FROM album alb
	WHERE alb.Name LIKE CONCAT(aAlbumName, '%')
	ORDER BY alb.Name ASC;


	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlbumsByGenreAndReco` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAlbumsByGenreAndReco`(
	aGenreID int,
	aReco int
)
BEGIN
	IF aGenreID > 0 THEN
		SELECT alb.idalbum, trk.Recommended
		FROM track trk
		INNER JOIN album alb ON trk.idalbum = alb.idalbum
		WHERE ((trk.idPrimaryGenre = aGenreID) OR (trk.idSecondaryGenre = aGenreID))
		AND ((trk.Recommended = aReco) OR (trk.Recommended = 1))
		GROUP BY alb.idalbum
		ORDER by alb.Name;
	ELSE
		SELECT alb.idalbum, trk.Recommended
		FROM track trk
		INNER JOIN album alb ON trk.idalbum = alb.idalbum
		WHERE (trk.Recommended = aReco) OR (trk.Recommended = 1)
		GROUP BY alb.idalbum
		ORDER by alb.Name;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlbumsFromArtistID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAlbumsFromArtistID`(
	aArtistID bigint
)
BEGIN
	SELECT alb.idAlbum as 'ID', alb.Name as 'Album', alb.idPrimaryGenre as 'PrimaryGenreID', 
		gOne.Name as 'PrimaryGenre' , alb.idSecondaryGenre as 'SecondaryGenreID', gTwo.Name as 'SecondaryGenre'
	FROM kure.album alb
	LEFT OUTER JOIN kure.genre gOne ON alb.idPrimaryGenre = gOne.idgenre
	LEFT OUTER JOIN kure.genre gTwo ON alb.idSecondaryGenre = gTwo.idgenre
	WHERE alb.idArtist = aArtistID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlbumsFromArtistName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAlbumsFromArtistName`(
	aArtistName varchar(45)
)
BEGIN
	SET @ArtistID = (SELECT idArtist FROM kure.artist WHERE Name = aArtistName);

	IF (@ArtistID IS NULL) THEN
	SELECT 'Error, no results found' as 'Error';

	ELSE
	SELECT idAlbum as 'ID', Name as 'Album Name'
	FROM kure.album
	WHERE idArtist = @ArtistID;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlbumsFromDistributorID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAlbumsFromDistributorID`(
	aDistributorID bigint
)
BEGIN
	SELECT 
		rot.idrotation,
		rot.physicalReceived,
		rot.digitalReceived,
		rot.physicalReceivedDate,
		rot.digitalReceivedDate,
		rot.stationPriority,
		rot.iddistributor,
		rot.idalbum,
		rot.karmaPromoter,
		rot.karmaMusicDirector,
		rot.karmaReviewer,
		rot.scorePromoter,
		rot.scoreMusicDirector,
		rot.iduser,
		rot.ignoreInChart,
		rot.cmjAdds,
		rot.cmjCurrent,
		rot.cmjPeak,
		rot.cmjPeakDate,
		rot.cmjAddDate,
		art.Name as 'Artist',
		alb.Name as 'Album', 
		alb.idPrimaryGenre as 'PrimaryGenreID', 
		gOne.Name as 'PrimaryGenre' , 
		alb.idSecondaryGenre as 'SecondaryGenreID', 
		gTwo.Name as 'SecondaryGenre'
	FROM rotation rot
	INNER JOIN album alb ON rot.idalbum = alb.idalbum
	INNER JOIN artist art ON art.idartist = alb.idartist
	LEFT OUTER JOIN genre gOne ON alb.idPrimaryGenre = gOne.idgenre
	LEFT OUTER JOIN genre gTwo ON alb.idSecondaryGenre = gTwo.idgenre
	WHERE rot.idDistributor = aDistributorID AND rot.ignoreInChart = 0
	ORDER BY rot.stationPriority;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlbumsWhereTrackLike` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAlbumsWhereTrackLike`(
	aTrackName varchar(20)
)
BEGIN
	SELECT alb.idAlbum
	FROM track trk
	INNER JOIN album alb ON trk.idalbum = alb.idalbum
	WHERE trk.Name LIKE CONCAT(aTrackName, '%')
	GROUP BY alb.idalbum
	ORDER BY alb.Name ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllDistributors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllDistributors`()
BEGIN
	SELECT d.iddistributor as 'iddistributor',
		d.name as 'distributorname',
		d.phone,
		d.email,
		d.contactName,
		d.location,
		d.affiliated,
		d.website,
		d.digitalDownload,
		d.weight
	FROM distributor d
	ORDER BY name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllGenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllGenre`()
BEGIN
	SELECT idGenre as 'idGenre', Name as 'Name' FROM genre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllGrantInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllGrantInfo`(
	aGrantID int
)
BEGIN
	SELECT 
		g.idgrant as 'GrantID', 
		g.name as 'GrantName', 
		g.message as 'Message',
		g.maxplaycount as 'MaxPlayCount',
		g.enddate as 'EndDate',
		u.username as 'UserName',
		u.iduser as 'UserID'
	FROM kure.grant g
	LEFT OUTER JOIN user u ON g.modifieduser = u.iduser
	WHERE idgrant = aGrantID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllPSAInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllPSAInfo`(
	aPSAID int
)
BEGIN
	SELECT idpsa as 'PSAID', name as 'Name',
		message as 'Message', createdate as 'CreateDate',
		enddate as 'EndDate', playcount as 'PlayCount',
		maxplaycount as 'MaxPlayCount', iduser as 'UserID',
		sponsor as 'Sponsor'
	FROM psa
	WHERE idpsa = aPSAID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllPSAs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllPSAs`()
BEGIN
SELECT p.idpsa as 'PSAID', p.name as 'Name',
	p.createdate as 'CreateDate', p.playcount as 'PlayCount',
	p.sponsor as 'Sponsor', u.username as 'UserName', u.iduser as 'UserID',
	u.lastname as 'LastName', 
	(((p.maxplaycount IS NULL)OR(p.playcount < p.maxplaycount))AND((p.enddate IS NULL) OR (p.enddate >= current_timestamp()))) as 'Active'
	FROM psa p
	LEFT OUTER JOIN user u ON p.iduser = u.iduser
	ORDER BY PlayCount DESC;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllTrackData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllTrackData`(
	TrackID bigint
)
BEGIN
-- --------------------------------------------------------------------------------
-- Created by Robert Clabough
-- 2/20/2014
-- Cretaed to get all information about a single track, used to modify tracks by track ID
-- --------------------------------------------------------------------------------

	SELECT trk.idtrack, trk.Name as 'TrackName', alb.idalbum, alb.Name as 'AlbumName',
		art.idartist, art.Name as 'ArtistName',
		trk.CreateDate, trk.EndDate, trk.ReleaseDate,
		trk.FCC, trk.Recommended, trk.ITLID, trk.Path, trk.PlayCount, trk.idsubsonic,
		trk.idPrimaryGenre as 'PrimaryGenreID', pgen.Name as 'PrimaryGenre',
		trk.idPrimaryGenre as 'SecondGenreID', sgen.Name as 'SecondGenre'
	FROM track trk
	INNER JOIN album alb ON trk.idalbum = alb.idalbum
	INNER JOIN artist art ON alb.idartist = art.idartist
	LEFT OUTER JOIN genre pgen ON alb.idprimarygenre = pgen.idgenre
	LEFT OUTER JOIN genre sgen ON alb.idsecondarygenre = sgen.idgenre
	WHERE trk.idtrack = TrackID;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllTracksByGenreAndReco` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllTracksByGenreAndReco`(
	aGenreID int,
	aReco int
)
BEGIN
	IF aGenreID > 0 THEN
		SELECT idTrack, idArtist, idAlbum, Name, CreateDate, FCC, Recommended, PlayCount, idPrimaryGenre, idSecondaryGenre, idsubsonic
		FROM track trk
		WHERE ((trk.idPrimaryGenre = aGenreID) OR (trk.idSecondaryGenre = aGenreID))
		AND ((trk.Recommended = aReco) OR (trk.Recommended = 1))
		ORDER BY Name;
	ELSE
		SELECT idTrack, idArtist, idAlbum, Name, CreateDate, FCC, Recommended, PlayCount, idPrimaryGenre, idSecondaryGenre
		FROM track trk
		WHERE (trk.Recommended = aReco) OR (trk.Recommended = 1)
		ORDER BY Name;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllUsers`()
BEGIN
	SELECT 
		u.iduser as 'iduser',
		u.idusertype as 'idusertype',
		ut.typename as 'UserTypeName',
		u.firstname as 'FirstName',
		u.lastname as 'LastName',
		u.username as 'username',
		u.email as 'email',
		u.startdate as 'StartDate',
		u.enddate as 'EndDate',
		us.logon as 'LastLogOn',
		us.logoff as 'LastLogOff',
		(u.enddate IS NULL OR u.enddate <= current_timestamp()) as 'Active'
	FROM user u
	INNER JOIN usertype ut ON u.idusertype = ut.idusertype
	LEFT OUTER JOIN usersession us ON u.idlastlogon = us.idusersession
	WHERE u.hidden != 1
	ORDER BY u.username;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllUserTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllUserTypes`()
BEGIN
	SELECT
			idusertype as 'idusertype',
			typename as 'usertypename',
			LibraryView as 'plibraryview',
			LibraryManage as 'plibrarymanage',
			PSAView as 'ppsaview',
			PSAEdit as 'ppsamanage',
			GrantView as 'pgrantview',
			GrantEdit as 'pgrantedit',
			ManageUsers as 'pmanageusers',
			PlaylistEditor as 'pplaylistedit',
			EditPermissions as 'ppermissionedit',
			EditUserType as 'peditusertype',
			OnAirSignOn as 'onairsignon',
			ReviewMusic as 'reviewmusic'
	FROM usertype
	ORDER BY idusertype;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetArtistList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetArtistList`()
BEGIN
	SELECT idArtist as 'ID', Name as 'Artist'
	FROM kure.artist;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetArtistListAlphabetical` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetArtistListAlphabetical`()
BEGIN
SELECT idArtist as 'ID', Name as 'Artist'
	FROM kure.artist
	ORDER BY Name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetArtistsAutoComplete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetArtistsAutoComplete`(
	aArtistName varchar(20)
)
BEGIN
-- ------------------------------------------
--  GetTracksLike
--  Builds a list of tracks where the name is like
--  'something' which is just some characters.
--  This is coupled with GetArtistWHhereTracksLike and GetAlbumsWhereTrackLike
--
-- ------------------------------------------
	SELECT idArtist, Name
	FROM artist art
	WHERE art.Name LIKE CONCAT(aArtistName, '%')
	ORDER BY art.Name ASC;


	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetArtistsByGenreAndReco` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetArtistsByGenreAndReco`(
	aGenreID int,
	aReco int
)
BEGIN
	IF aGenreID > 0 THEN
		SELECT art.idartist, trk.Recommended
		FROM track trk
		INNER JOIN artist art ON trk.idartist = art.idartist
		WHERE ((trk.idPrimaryGenre = aGenreID) OR (trk.idSecondaryGenre = aGenreID))
		AND ((trk.Recommended = aReco) OR (trk.Recommended = 1))
		GROUP BY art.idartist
		ORDER by art.Name;
	ELSE
		SELECT art.idartist, trk.Recommended
		FROM track trk
		INNER JOIN artist art ON trk.idartist = art.idartist
		WHERE trk.Recommended = aReco OR trk.Recommended = 1
		GROUP BY art.idartist
		ORDER by art.Name;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetArtistsWhereTrackLike` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetArtistsWhereTrackLike`(
	aTrackName varchar(20)
)
BEGIN
	SELECT art.idArtist
	FROM track trk
	INNER JOIN artist art ON trk.idartist = art.idartist
	WHERE trk.Name LIKE CONCAT(aTrackName, '%')
	GROUP BY art.idartist
	ORDER BY art.Name ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCountPlaysGivenTimeframe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetCountPlaysGivenTimeframe`(
	aStartDate datetime
)
BEGIN
-- ------------------------
-- Used to get stats about the tracks played in given time.  Usually set to one month.
--  Using this we can create graphs and other cool chart things
-- ------------------------
	SELECT trk.Name as 'TrackName', ptrk.idtrack as 'TrackID', ptrk.idplaytrack as 'PlayID',
	art.Name as 'ArtistName', art.idartist as 'ArtistID', 
		alb.Name as 'AlbumName', alb.idalbum as 'AlbumID', trk.playcount as 'TotalPlayCount',
		count(ptrk.idtrack) as 'TimeframeCount'
	FROM playtrack ptrk
	INNER JOIN track trk ON ptrk.idtrack = trk.idtrack
	INNER JOIN album alb ON trk.idalbum = alb.idalbum
	INNER JOIN artist art ON alb.idartist = art.idartist
	WHERE ptrk.playdate > aStartDate
	GROUP BY trk.idtrack;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCurrentOnAirUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetCurrentOnAirUser`()
BEGIN
	SELECT u.username as 'UserName', u.iduser as 'UserID', u.firstname as 'FirstName', u.lastname as 'LastName'
	FROM onairsession oas
	INNER JOIN user u ON oas.iduser = u.iduser
	WHERE oas.logoff IS null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDistributorByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetDistributorByID`(aDistributorid INT(11))
BEGIN
	SELECT d.iddistributor as 'iddistributor',
		d.name as 'distributorname',
		d.phone,
		d.email,
		d.contactName,
		d.location,
		d.affiliated,
		d.website,
		d.digitalDownload,
		d.weight
	FROM distributor d
	WHERE d.iddistributor = aDistributorid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDJs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetDJs`()
BEGIN

select u.iduser, u.FirstName, u.LastName, up.nickname, u.username, up.iduserprofile, ut.idusertype, u.email as 'email', 
		u.enddate, current_timestamp(),
	(SELECT  1 idonairsession FROM onairsession WHERE iduser = u.iduser AND logoff is null limit 1) as 'OnAir'
from user u
inner join usertype ut ON u.idusertype = ut.idusertype
left outer join userprofile up ON u.iduser = up.iduser
where ut.OnAirSignOn = 1
AND (u.enddate IS NULL OR u.enddate > current_timestamp() OR u.enddate = 0)
AND u.hidden = 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEligibleGrants` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetEligibleGrants`()
BEGIN
	SELECT idgrant as 'GrantID', playcount as 'PlayCount', 
		startdate as 'StartDate', enddate as 'EndDate',
		maxplaycount as 'MaxPlayCount',
		TIMESTAMPDIFF(SECOND, current_timestamp(), g.enddate) as 'TimeLeft'
	FROM kure.grant g
	WHERE ((enddate IS NULL) OR (enddate >= current_timestamp()));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEligiblePSAs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetEligiblePSAs`()
BEGIN

	SELECT idpsa as 'PSAID', playcount as 'PlayCount', 
		createdate as 'StartDate', enddate as 'EndDate',
		maxplaycount as 'MaxPlayCount',
		TIMESTAMPDIFF(SECOND, current_timestamp(), p.enddate) as 'TimeLeft'
	FROM psa p
	WHERE (((p.maxplaycount IS NULL)OR(p.playcount < p.maxplaycount))AND((p.enddate IS NULL) OR (p.enddate >= current_timestamp())));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetErrors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetErrors`()
BEGIN
	SELECT l.iderrorlog, u.iduser as 'UserID', l.message as 'Message', l.stacktrace as 'StackTrace', 
		l.logdate as 'CreateDate', u.username as 'UserName', u.firstName as 'FirstName',
		u.lastName as 'LastName', l.ipaddress as 'IPAddress'
	FROM errorlog l
	LEFT OUTER JOIN user u ON l.iduser = u.iduser
	ORDER BY l.logdate desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetExceptions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetExceptions`()
BEGIN
	#Created by Robert Clabough
	#3/3/2014
	#Created to show exceptions easily to user
	SELECT el.idexceptionlog as 'ExceptionLogID', el.message as 'message', el.stacktrace as 'stacktrace',
		el.createdate as 'createdate', el.iduser as 'UserID', u.username as 'UserName', u.lastname as 'LastName',
		u.firstname as 'FirstName', el.ipaddress as 'IPAddress'
	FROM exceptionlog el
	LEFT OUTER JOIN user u ON el.iduser = u.iduser
	ORDER BY createdate desc
	LIMIT 100;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetExceptionsByUserID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetExceptionsByUserID`(
	aUserID int
)
BEGIN
	SELECT 
		idexceptionlog as 'ID', 
		message, 
		stacktrace, 
		createdate, 
		iduser, 
		ipaddress as 'IPAddress'
	FROM exceptionlog
	WHERE iduser = aUserID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetGrantBasicInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetGrantBasicInfo`()
BEGIN

	SELECT
		idgrant as 'GrantID',
		name as 'GrantName',
		startdate as 'CreateDate',
		playcount as 'PlayCount',
		(((maxplaycount IS NULL)OR(playcount < maxplaycount))AND((enddate IS NULL)OR(current_timestamp() < enddate))) as 'Active'
	FROM
		kure.grant g
 		;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetLast25Played` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetLast25Played`()
BEGIN
	SELECT trk.idtrack as 'TrackID', trk.Name as 'TrackName', art.Name as 'ArtistName', alb.Name as 'AlbumName', play.playdate as 'PlayDate'
	FROM playtrack play
	INNER JOIN track trk ON play.idtrack = trk.idtrack
	INNER JOIN album alb ON trk.idalbum = alb.idalbum
	INNER JOIN artist art ON trk.idartist = art.idartist
	ORDER BY playdate desc
	LIMIT 25;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMost25PopularTracks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetMost25PopularTracks`(
	aStartTime datetime
)
BEGIN
	SELECT trk.Name as 'TrackName', art.Name as 'ArtistName', ptrk.idplaytrack as 'LastPlayID', trk.idtrack as 'TrackID', count(ptrk.idtrack) as 'TimeframePlayCount'
	FROM playtrack ptrk
	INNER JOIN track trk ON ptrk.idtrack = trk.idtrack
	INNER JOIN artist art on trk.idartist = art.idartist
	WHERE ptrk.playdate >= aStartTime
	GROUP BY ptrk.idtrack
	ORDER  BY count(ptrk.idtrack) desc
	LIMIT 25;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPlayableTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetPlayableTypes`()
BEGIN
	SELECT idplayabletypes as 'TypeID', name as 'TypeName'
	FROM playabletypes;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPlaylistTracks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetPlaylistTracks`(
	aPlaylistID int
)
BEGIN
-- ---------------------------------------------------------------------
-- Created by Robert Clabough
-- 
-- Pulls actual track data from a playlist and then sends it back up.
--
--  Modified on 3/28/14
--    Fixed order mixup from tracks.  Added the order by clause at the end
--
-- ----------------------------------------------------------------------

	#@TrackList is now our comma delimited tracklist.
	SET @TrackList = (SELECT tracks FROM playlist WHERE idplaylist = aPlaylistID LIMIT 1);
	SELECT trk.idtrack, alb.idalbum, art.idartist, trk.Name as 'TrackName', alb.Name as 'AlbumName',
		art.Name as 'ArtistName', trk.CreateDate, trk.ReleaseDate, trk.FCC, trk.Recommended,
		trk.PlayCount, gen1.idgenre as 'PrimaryGenreID', gen1.name as 'PrimaryGenreName',
		gen2.idgenre as 'SecondaryGenreID', gen2.name as 'SecondaryGenreName', trk.modified
	FROM track trk
		INNER JOIN album alb ON trk.idalbum = alb.idalbum
		INNER JOIN artist art ON alb.idartist = art.idartist
		LEFT OUTER JOIN genre gen1 ON trk.idPrimaryGenre = gen1.idgenre
		LEFT OUTER JOIN genre gen2 ON trk.idSecondaryGenre = gen2.idgenre
	WHERE FIND_IN_SET(idtrack, @TrackList) <> 0
		AND ((trk.EndDate < current_timestamp()) OR (trk.EndDate IS NULL))
	ORDER BY find_in_set(idtrack, @TrackList)
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPlaysByTimeSpan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetPlaysByTimeSpan`(
	aStartTime datetime,
	aEndTime datetime
)
BEGIN
	SELECT trk.idtrack as 'TrackID', alb.idalbum as 'AlbumID', art.idartist as 'ArtistID',
			trk.Name as 'TrackName', alb.Name as 'AlbumName', art.Name as 'ArtistName',
			u.username as 'UserName', ptrk.playdate as 'PlayDate'
	FROM playtrack ptrk
	INNER JOIN user u ON ptrk.iduser = u.iduser
	INNER JOIN track trk ON ptrk.idtrack = trk.idtrack
	INNER JOIN album alb ON trk.idalbum = alb.idalbum
	INNER JOIN artist art ON alb.idartist = art.idartist
	WHERE ptrk.playdate > aStartTime
	AND ptrk.playdate < aEndTime
	ORDER BY ptrk.playdate DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPlaysByUserID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetPlaysByUserID`(
	aUserID bigint
)
BEGIN
	
select trk.Name as 'TrackName', alb.Name as 'AlbumName', art.Name as 'ArtistName',
	ptrk.playdate as 'PlayDate', u.username as 'UserName', u.FirstName as 'First', u.LastName as 'Last',
	trk.playcount as 'PlayCount',
	trk.idtrack as 'TrackID', alb.idalbum as 'AlbumID', art.idartist as 'ArtistID',
	ptrk.idplaytrack as 'PlayTrackID', u.iduser as 'UserID'
from track trk
inner join album alb on trk.idalbum = alb.idalbum
inner join artist art on alb.idartist = art.idartist
inner join playtrack ptrk on trk.idtrack = ptrk.idtrack
inner join user u on ptrk.iduser = u.idUser
where u.iduser = aUserID
order by ptrk.playdate desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetRecentPlays` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetRecentPlays`()
BEGIN
	SET @TrackType = (SELECT idplayabletypes from playabletypes where name='Track');
	SET @GrantType = (SELECT idplayabletypes from playabletypes where name = 'Grant');
	SET @PSAType = (SELECT idplayabletypes from playabletypes WHERE name = 'PSA');

	SELECT ptrk.idplaytrack as 'PlayID', ptrk.idtrack as 'ItemID', t.name as 'Name', ptrk.iduser as 'UserID', ptrk.idonairsession as 'OnAirSessionID',
			ptrk.playdate as 'PlayDate', @TrackType as 'Type'
	FROM playtrack ptrk
	INNER JOIN track t ON ptrk.idtrack = t.idtrack
	UNION 
	SELECT pgnt.idplaygrant as 'PlayID', pgnt.idgrant as 'ItemID', g.name as 'Name', pgnt.iduser as 'UserID', pgnt.idonairsession as 'OnAirSessionID',
			pgnt.playdate as 'PlayDate', @GrantType as 'Type'
	FROM playgrant pgnt
	INNER JOIN kure.grant g ON pgnt.idgrant = g.idgrant
	UNION 
	SELECT ppsa.idplaypsa as 'PlayID', ppsa.idpsa as 'ItemID', p.name as 'Name', ppsa.iduser as 'UserID', ppsa.idonairsession as 'OnAirsessionID',
			ppsa.playdate as 'PlayDate', @PSAType as 'Type'
	FROM playpsa ppsa
	INNER JOIN psa p ON ppsa.idpsa = p.idpsa
	order by playdate desc
	LIMIT 0, 100;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetRecommendedArtistAlbum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetRecommendedArtistAlbum`()
BEGIN
	SELECT idArtist, idAlbum, Name, CreateDate, FCC, Recommended, PlayCount, idPrimaryGenre, idSecondaryGenre
	FROM track
	WHERE recommended = 1
	AND (EndDate IS NULL OR EndDate < current_timestamp());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetReviewers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetReviewers`()
BEGIN
	SELECT 
		u.iduser, 
		u.FirstName, 
		u.LastName, 
		up.nickname, 
		u.username, 
		up.iduserprofile, 
		ut.idusertype, 
		u.email as 'email', 
		u.enddate, CURRENT_TIMESTAMP()
	FROM user u
	INNER JOIN usertype ut ON u.idusertype = ut.idusertype
	LEFT OUTER JOIN userprofile up ON u.iduser = up.iduser
	WHERE ut.ReviewMusic = 1
	AND (u.enddate IS NULL OR u.enddate > current_timestamp() OR u.enddate = 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetRotation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetRotation`()
BEGIN
	SELECT 
		rot.idrotation,
		rot.physicalReceived,
		rot.digitalReceived,
		rot.physicalReceivedDate,
		rot.digitalReceivedDate,
		rot.stationPriority,
		rot.iddistributor,
		rot.idalbum,
		rot.karmaPromoter,
		rot.karmaMusicDirector,
		rot.karmaReviewer,
		rot.scorePromoter,
		rot.scoreMusicDirector,
		rot.iduser,
		rot.ignoreInChart,
		rot.cmjAdds,
		rot.cmjCurrent,
		rot.cmjPeak,
		rot.cmjPeakDate,
		rot.cmjAddDate,
		rot.commentsMusicDirector,
		rot.commentsReviewer,
		rot.reviewDate,
		art.Name as 'Artist',
		alb.Name as 'Album', 
		alb.idPrimaryGenre as 'PrimaryGenreID', 
		gOne.Name as 'PrimaryGenre' , 
		alb.idSecondaryGenre as 'SecondaryGenreID', 
		gTwo.Name as 'SecondaryGenre'
	FROM rotation rot
	INNER JOIN album alb ON rot.idalbum = alb.idalbum
	INNER JOIN artist art ON art.idartist = alb.idartist
	LEFT OUTER JOIN genre gOne ON alb.idPrimaryGenre = gOne.idgenre
	LEFT OUTER JOIN genre gTwo ON alb.idSecondaryGenre = gTwo.idgenre
	WHERE rot.ignoreInChart = 0
	ORDER BY rot.stationPriority;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTrackChunks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTrackChunks`(
	aStartIndex bigint,
	aNumberToReturn bigint
)
BEGIN
	SELECT trk.idtrack as 'TrackID', trk.Name as 'TrackName', alb.idalbum as 'AlbumID', alb.Name as 'AlbumName', 
		art.idartist as 'ArtistID', art.Name as 'ArtistName', trk.ReleaseDate as 'ReleaseDate', trk.FCC as 'FCC',
		trk.idsubsonic as 'idsubsonic',
		trk.Recommended as 'Recommended', trk.PlayCount as 'PlayCount'
	FROM kure.track trk
	INNER JOIN kure.album alb ON trk.idalbum = alb.idalbum
	INNER JOIN kure.artist art ON alb.idartist = art.idartist
	WHERE trk.idtrack >= aStartIndex
		AND trk.idtrack < (aStartIndex + aNumberToReturn)
		AND ((trk.EndDate IS NULL)OR(trk.EndDate > current_timestamp()));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTrackChunksAlphabetical` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTrackChunksAlphabetical`(
	aLastWord varchar(255)
)
BEGIN

	SELECT trk.idtrack as 'TrackID', trk.Name as 'TrackName', alb.idalbum as 'AlbumID', alb.Name as 'AlbumName', 
		art.idartist as 'ArtistID', art.Name as 'ArtistName', trk.ReleaseDate as 'ReleaseDate', trk.FCC as 'FCC',
		trk.idsubsonic,
		trk.Recommended as 'Recommended', trk.PlayCount as 'PlayCount', trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM kure.track trk
	INNER JOIN kure.album alb ON trk.idalbum = alb.idalbum
	INNER JOIN kure.artist art ON alb.idartist = art.idartist
	WHERE trk.Name > aLastWord
	AND ((trk.EndDate IS NULL)OR(trk.EndDate > current_timestamp()))
	ORDER BY trk.Name
	LIMIT 100;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTrackPlaysByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTrackPlaysByID`(
	aTrackID bigint
)
BEGIN
	SELECT pltrk.idplaytrack as 'ID', us.username as 'UserName',
		pltrk.iduser as 'UserID', pltrk.idonairsession as 'OnAirID',
		pltrk.PlayDate as 'Time'
	FROM kure.playtrack pltrk
	INNER JOIN kure.user us ON pltrk.iduser = us.iduser
	WHERE pltrk.idtrack = aTrackID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTracksByAlbumID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTracksByAlbumID`(
	aAlbumID bigint
)
BEGIN
	SELECT trk.idTrack as 'ID', trk.Name as 'Track', trk.FCC, trk.Recommended, trk.PlayCount, art.Name as 'Artist',
		trk.idsubsonic,
		trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM kure.track trk
	INNER JOIN kure.artist art ON trk.idartist = art.idartist
	WHERE idalbum = aAlbumID
	AND ((trk.EndDate IS NULL)OR(trk.EndDate > current_timestamp()));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTracksByAlbumName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTracksByAlbumName`(
	aAlbumName varchar(255)
)
BEGIN
	SELECT idTrack as 'ID', trk.Name as 'Track Name', trk.CreateDate as 'Create Date',
		trk.idsubsonic,
		trk.ReleaseDate as 'Release Date', trk.FCC as 'FCC', trk.Recommended as 'Recommended',
		trk.PlayCount as 'Play Count', trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM kure.track trk
	INNER JOIN kure.album alb ON trk.idalbum = alb.idalbum
	WHERE alb.Name = aAlbumName
	AND trk.EndDate IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTracksByArtistID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTracksByArtistID`(
	aArtistID int
)
BEGIN
	SELECT idTrack as 'ID', trk.Name as 'Track', alb.Name as 'Album', alb.idalbum as 'AlbumID', art.Name as 'Artist', trk.CreateDate as 'Create Date',
		trk.idsubsonic,
		trk.ReleaseDate as 'Release Date', trk.FCC as 'FCC', trk.Recommended as 'Recommended',
		trk.PlayCount as 'Play Count', trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM kure.track trk
	INNER JOIN kure.album alb ON trk.idalbum = alb.idalbum
	INNER JOIN kure.artist art ON alb.idartist = art.idartist
	WHERE art.idartist = aArtistID
	AND ((trk.EndDate IS NULL)OR(trk.EndDate > current_timestamp()));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTracksByArtistName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTracksByArtistName`(
	aArtistName varchar(255)
)
BEGIN
	SELECT idTrack as 'ID', trk.Name as 'Track', alb.Name as 'Album', trk.CreateDate as 'Create Date',
		trk.idsubsonic,
		trk.ReleaseDate as 'Release Date', trk.FCC as 'FCC', trk.Recommended as 'Recommended',
		trk.PlayCount as 'Play Count', trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM kure.track trk
	INNER JOIN kure.album alb ON trk.idalbum = alb.idalbum
	INNER JOIN kure.artist art ON alb.idartist = art.idartist
	WHERE art.Name = aArtistName
	AND ((trk.EndDate IS NULL)OR(trk.EndDate > current_timestamp()));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTracksLike` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTracksLike`(
	aTrackName varchar(20)
)
BEGIN
-- ------------------------------------------
--  GetTracksLike
--  Builds a list of tracks where the name is like
--  'something' which is just some characters.
--  This is coupled with GetArtistWHhereTracksLike and GetAlbumsWhereTrackLike
--
-- ------------------------------------------
	SELECT idTrack, idArtist, idAlbum, Name, CreateDate, FCC, Recommended, PlayCount, idPrimaryGenre, idSecondaryGenre,
			idsubsonic
	FROM track trk
	WHERE trk.Name LIKE CONCAT(aTrackName, '%')
	ORDER BY trk.Name ASC;


	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTrackSubsonicID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetTrackSubsonicID`(
	TrackID bigint
)
BEGIN
-- --------------------------------------------------------------------------------
-- Created by Robert Clabough
-- 2/20/2014
-- Cretaed to get all information about a single track, used to modify tracks by track ID
-- --------------------------------------------------------------------------------

	SELECT trk.idsubsonic as 'SubsonicID'
	FROM track trk
	WHERE trk.idtrack = TrackID;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserFromName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetUserFromName`(
	aUserName varchar(45)
)
BEGIN
	SET @UserID = (SELECT iduser FROM user u WHERE username = aUserName AND ((u.enddate IS NULL) OR (u.enddate > current_timestamp()) OR (u.enddate = 0)));
	IF(@UserID IS NOT NULL) THEN 
		SELECT iduser, idusertype, username, passwordhash, startdate, enddate, firstname, lastname, salt from user where username = aUserName;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetUserProfile`(
	aUserID int
)
BEGIN

select up.iduserprofile as 'UserProfileID', up.iduser as 'UserID',
	up.nickname as 'NickName', up.bio as 'Bio', up.motto as 'Motto',
	(SELECT  1 idonairsession FROM onairsession WHERE iduser = u.iduser AND logoff is null limit 1) as 'OnAir',
	u.username as 'UserName', u.FirstName as 'FirstName', u.LastName as 'LastName'
	from userprofile up
	inner join user u on up.iduser = u.iduser
	where up.iduser = aUserID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertCustomAlbum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `InsertCustomAlbum`(
	aArtistID int,
	aAlbumName varchar(255),
	aPriority bit,
	aPrimaryGenreID int,
	aSecondaryGenreID int
)
BEGIN
	#Check for this value already
	SET @ExistingAlbumID = (SELECT idalbum FROM album WHERE Name = aAlbumName AND idartist = aArtistID);

	IF(@ExistingAlbumID IS NULL) THEN
		INSERT INTO album(idartist, Name, Priority, idprimarygenre, idsecondarygenre)
		VALUES(aArtistID, aAlbumName, aPriority, aPrimaryGenreID, aSecondaryGenreID);
		SELECT @@IDENTITY as 'AlbumID';
	ELSE
		SELECT @ExistingAlbumID as 'AlbumID';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertCustomArtist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `InsertCustomArtist`(
	aArtistName varchar(255)
)
BEGIN
	#Check for duplicate artist already in
	SET @PreviousArtistID = (SELECT idartist FROM artist WHERE Name = aArtistName);
	IF(@PreviousArtistID IS NULL) then
		INSERT INTO artist(Name) VALUES(aArtistName);
		SELECT @@Identity as 'ArtistID';
	ELSE
		SELECT @PreviousArtistID as 'ArtistID';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertCustomTrack` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `InsertCustomTrack`(
	aTrackName varchar(40),
	aAlbumID int,
	aArtistID int,
	aEndDate datetime,
	aReleaseDate datetime,
	aFCC bit,
	aRecommended bit,
	aPath varchar(500),
	aPlayCount int,
	aPrimaryGenreID int,
	aSecondaryGenreID int
	
)
BEGIN
	#Check to see for last time if this track does not already exist in the DB

	SET @ExistingTrackID = 
		(SELECT idtrack FROM track WHERE idalbum = aAlbumID AND idartist = aArtistID
			AND Name = aTrackName);

	#ExistingTrackID should be null.  If it is, great.  If not, don't do anything, and return error.

	IF(@ExistingTrackID IS NULL) THEN
		INSERT INTO track(idalbum, idartist, Name, CreateDate, EndDate, ReleaseDate, FCC, Recommended, ITLID, Path, PlayCount, idPrimaryGenre, idSecondaryGenre, modified, idsubsonic)
		VALUES(aAlbumID, aArtistID, aTrackname, current_timestamp(), aEndDate, aReleaseDate, aFCC, aRecommended, null, aPath, aPlayCount, aPrimaryGenreID, aSecondaryGenreID, 1, null);
		
		SELECT @@IDENTITY as 'TrackID';
	ELSE
		#Return the existing ID if it exists
		SELECT @ExistingTrackID as 'TrackID';
	END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertPlaylist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `InsertPlaylist`(
	aUserID int,
	aPlaylistName varchar(45),
	aTracks varchar(2048)
)
BEGIN
	#Created by Robert Clabough
	#2/26/2014
	#Builds a playlist
	SET @PreviousPlaylistID = (SELECT idplaylist FROM playlist WHERE name = aPlaylistName AND iduser = aUserID);
	IF(@PreviousPlaylistID IS NULL) then
		INSERT INTO playlist(iduser, name, tracks, createdate) VALUES(aUserID, aPlaylistName, aTracks, current_timestamp());
		SELECT @@IDENTITY;
	ELSE
		UPDATE playlist SET tracks = aTracks WHERE name = aPlaylistName AND iduser = aUserID;
		SELECT @PreviousPlaylistID;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LogError` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `LogError`(
	aUserID int,
	aMessage varchar(1024),
	aStackTrace varchar(1024), 
	aIpaddress varchar(50)
)
BEGIN
	INSERT INTO errorlog(iduser, message, stacktrace, logdate, ipaddress)
		VALUES(aUserID, aMessage, aStackTrace, current_timestamp(), aIpaddress);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LogException` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `LogException`(
	aUserID int,
	aMessage varchar(2048),
	aStackTrace varchar(2048),
	aIpaddress varchar(50)
)
BEGIN
-- -------------------
-- Created by Robert Clabough
-- 2/14/2014 - Happy Valentines Day!
-- Used for logging exceptions (non-user related errors)
-- PARAMETERS
-- aUserID - User logged in when exception occurred
-- aMessage - Message that was thrown (e.g. 'Index out of Bounds')
-- aStackTrace - Stack trace of exception
--
--  Primary key will be autoincremented, createddate will be taken from current timestamp
--
-- -------------------
	INSERT INTO exceptionlog(message, stacktrace, createdate, iduser, ipaddress)
		VALUES(aMessage, aStackTrace, current_timestamp(), aUserID, aIpaddress);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `OnAirLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `OnAirLogin`(
	aUserID int
)
BEGIN
-- --------------------------------------------------------------------------------
-- UserLogin
--
--  Created by Darren Hushak
--  3/24/14
--
-- Registers a new on air session
--
-- Modified on 3/28/14 by Robert Clabough
--   Will cancel any current on air sessions, essentially 'kicking' them off
-- --------------------------------------------------------------------------------
	UPDATE onairsession SET logoff = current_timestamp() where logoff is null;

	INSERT INTO onairsession(iduser, logon) VALUES(aUserID, current_timestamp);
	SET @OnAirID = @@IDENTITY;

	

	SELECT @OnAirID as 'OnAirID';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `OnAirLogout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `OnAirLogout`(
	aUserID int,
	aOnAirSessionID int
)
BEGIN
-- --------------------------------------------------------------------------------
-- UserLogin
--
--  Created by Darren Hushak
--  3/24/14
--
-- Logs out an on air session
-- --------------------------------------------------------------------------------
	SET @CorrectUser = (SELECT iduser FROM onairsession WHERE idonairsession = aOnAirSessionID);
	IF(@CorrectUser = aUserID) THEN
		UPDATE onairsession SET logoff = current_timestamp WHERE idonairsession = aOnAirSessionID;
	else
		CALL LogError(aUserID, 'User tried to log out of a different user\'s on air session', 'OnAirLogout Stored Procedure');
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PlayGrantByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `PlayGrantByID`(
	aGrantID bigint,
	aUserID int,
	aOnAirSessionID bigint
)
BEGIN
	#Plays a grant given grant ID, user ID, and on air session

	#Insert into the playgrant table.
	INSERT INTO playgrant(idgrant, iduser, idonairsession, playdate)
		VALUES(aGrantID, aUserID, aOnAirSessionID, current_timestamp());

	#Create a variable that is the last inserted ID (in playgrant)
	SET @PlayID = @@IDENTITY;

	#Update the play in the grant table
	UPDATE kure.grant SET playcount = playcount + 1 WHERE idgrant = aGrantID;

	#Return the new playID
	SELECT @PlayID as 'PlayID';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PlayPSAByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `PlayPSAByID`(
	aPSAID bigint,
	aUserID	int,
	aOnAirSession bigint
)
BEGIN
	INSERT INTO playpsa(idpsa, iduser, idonairsession, playdate)
		VALUES(aPSAID, aUserID, aOnAirSession, current_timestamp());
	UPDATE psa SET playcount = playcount + 1 WHERE idpsa = aPSAID;
	SELECT @@IDENTITY as 'PlayPSAID';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PlayTrackByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `PlayTrackByID`(
	aTrackID bigint,
	aUserID bigint,
	aOnAirSessionID bigint
)
BEGIN
-- ---------------------------------------------------
-- Created by Robert Clabough
--
-- PlayTrackByID
--  This will play the track, adding it to the PlayTrack table, and incrementing the playcount in track
-- ---------------------------------------------------

#Modified to 'return' the new play ID
	#Insert the play into the track plays table
	INSERT INTO kure.playtrack(idtrack, iduser, idonairsession, playdate)
		VALUES(aTrackID, aUserID, aOnAirSessionID, current_timestamp);
	SET @PlayID = @@IDENTITY;
	#Update the playcount in the track table
	UPDATE kure.track
		SET PlayCount = PlayCount + 1
		WHERE idtrack = aTrackID;

	SELECT @PlayID as 'PlayID';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReactivateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `ReactivateUser`(
	aUserID bigint
)
BEGIN
	UPDATE user 
	SET enddate = '0000-00-00 00:00:00' 
	WHERE iduser = aUserID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RetrieveUserPlaylistIDs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `RetrieveUserPlaylistIDs`(
	aUserID int
)
BEGIN
	#Very simple procedure to just return playlist IDs by user ID
	#Will be useful to display all possible playlists without returning a lot
	#of data that may never be seen
	SELECT idplaylist, name, createdate, iduser FROM playlist WHERE iduser = aUserID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReviewAlbum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `ReviewAlbum`(
	aUserID INT(11),
	aKarmaReviewer INT(11),
	aRotationID INT(11),
	aReviewerComments VARCHAR(1000))
BEGIN
	SET @VALIDUSER = 
		(SELECT
		usertype.ReviewMusic
		FROM usertype
		INNER JOIN user ON user.iduser = aUserID
		INNER JOIN rotation rot ON rot.iduser = aUserID
		WHERE usertype.idusertype = user.idusertype AND rot.idrotation = aRotationID);
	SET @CORRECTUSER =
		(SELECT
		rot.iduser
		FROM rotation rot
		WHERE rot.idrotation = aRotationID);
#	IF (@VALIDUSER = 1 AND @CORRECTUSER = aUserID) THEN
	IF (@VALIDUSER = 1) THEN
		UPDATE kure.rotation
		SET
			karmaReviewer = aKarmaReviewer,
			commentsReviewer = aReviewerComments,
			dateReviewed = CURRENT_TIMESTAMP
		WHERE idrotation = aRotationID;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdatePlayByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `UpdatePlayByID`(
	aPlayID bigint,
	aTrackID bigint,
	aUserID int
)
BEGIN
	#Allows updating the play in the table to a different song, if they got the id incorrect
	SET @CorrectUser = (SELECT iduser FROM playtrack WHERE idplaytrack = aPlayID);
	IF(@CorrectUser = aUserID) THEN
		UPDATE playtrack SET idtrack = aTrackID WHERE idplaytrack = aPlayID;
	else
		CALL LogError(aUserID, 'Unknown user tried to update a play', 'UpdatePlayByID Stored Procedure');
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateTrackData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `UpdateTrackData`(
	aTrackID bigint,
	aEndDate datetime,
	aReleaseDate datetime,
	aFCC bit,
	aRecommended bit,
	aPlayCount int,
	aPrimaryGenreID int,
	aSecondaryGenreID int

)
BEGIN
-- --------------------------------------------------------------------------------
-- Created by Robert Clabough
-- 2/21/2014
-- 
-- Updates track data from provided, marks modified to 1.
-- --------------------------------------------------------------------------------

	UPDATE track SET EndDate = aEndDate, ReleaseDate = aReleaseDate, FCC = aFCC, Recommended = aRecommended,
		PlayCount = aPlayCount, idPrimaryGenre = aPrimaryGenreID, idSecondaryGenre = aSecondaryGenreID,
		modified = 1
	WHERE idtrack = aTrackID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `UpdateUser`(
	aUserID bigint,
	aFirstName varchar(255),
	aLastName varchar(255),
	aEmail varchar(500),
	aUserTypeID bigint
)
BEGIN
	UPDATE user 
	SET firstname = aFirstName, lastname = aLastName, email = aEmail, idusertype = aUserTypeID 
	WHERE iduser = aUserID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateUserType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `UpdateUserType`(
	aUserTypeID bigint,
	aLibraryView bit,
	aLibraryManage bit,
	aPSAView bit,
	aPSAEdit bit,
	aGrantView bit,
	aGrantEdit bit,
	aManageUsers bit,
	aEditPermissions bit,
	aEditUserType bit,
	aOnAirSignon bit,
	aReviewMusic bit
)
BEGIN

	UPDATE usertype
		SET 
		LibraryView = aLibraryView, 
		LibraryManage = aLibraryManage, 
		PSAView = aPSAView, 
		PSAEdit = aPSAEdit, 
		GrantView = aGrantView, 
		GrantEdit = aGrantEdit, 
		ManageUsers = aManageUsers, 
		PlaylistEditor = 1, 
		EditPermissions = aEditPermissions, 
		EditUserType = aEditUserType, 
		OnAirSignOn = aOnAirSignOn,
		ReviewMusic = aReviewMusic
	WHERE idusertype = aUserTypeID;
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UserLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `UserLogin`(
	aUserID int
)
BEGIN
-- --------------------------------------------------------------------------------
-- UserLogin
--
--  Created by Robert Clabough
--  2/18/2014
--  Modified on 3/26/2014
--    Modified now because this is not the main 'login' script anymore.  This will start a session in the usersession table.
--    'Returns' the new ID in usersession
--
-- Checks the password hash against the one that is stored in the database.  If it is
-- true then it logs the user in by creating a new user session.  It will return 0 if successful
-- and 1 if there was an error.
-- --------------------------------------------------------------------------------

		#Insert into usersession
		INSERT INTO usersession(iduser, logon) VALUES(aUserID, current_timestamp);
		
		SET @sid = @@IDENTITY;

		#update the last login to this.
		UPDATE user SET idlastlogon = @sid WHERE iduser = aUserID;

		SELECT @sid as 'ID', ut.typename as 'UserTypeName', ut.LibraryView as 'LibraryView',
		ut.LibraryManage as 'LibraryManage', ut.PSAView as 'PSAView', ut.PSAEdit as 'PSAEdit',
		ut.GrantView as 'GrantView', ut.GrantEdit as 'GrantEdit', ut.ManageUsers as 'ManageUsers',
		ut.PlaylistEditor as 'PlaylistEdit', ut.EditPermissions as 'EditPermissions',
		ut.EditUserType as 'EditUserType', ut.OnAirSignOn as 'OnAirSignOn'
		FROM user u
		INNER JOIN usertype ut ON u.idusertype = ut.idusertype
		WHERE u.iduser = aUserID
		AND (u.enddate IS NULL OR u.enddate > current_timestamp() OR u.enddate = 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:19
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `track` (
  `idtrack` bigint(20) NOT NULL AUTO_INCREMENT,
  `idalbum` bigint(20) DEFAULT NULL,
  `idartist` bigint(20) DEFAULT NULL,
  `Name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `ReleaseDate` date DEFAULT NULL,
  `FCC` bit(1) DEFAULT NULL,
  `Recommended` bit(1) DEFAULT NULL,
  `ITLID` bigint(20) DEFAULT NULL,
  `Path` varchar(1023) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PlayCount` int(11) DEFAULT NULL,
  `idPrimaryGenre` int(11) DEFAULT '0',
  `idSecondaryGenre` int(11) DEFAULT '0',
  `modified` bit(1) DEFAULT b'0' COMMENT 'Set to 1 if this row has been manually modified.  If it has been, it cannot be overridden by a batch import',
  `idsubsonic` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idtrack`),
  KEY `IDTRACKALBUM_idx` (`idalbum`),
  KEY `IDTRACKARTIST_idx` (`idartist`),
  KEY `IDTRACKGENREPRIM_idx` (`idPrimaryGenre`),
  KEY `IDTRACKGENRESEC_idx` (`idSecondaryGenre`)
) ENGINE=InnoDB AUTO_INCREMENT=19440 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:14
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `idusertype` int(11) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `salt` varchar(32) DEFAULT NULL,
  `passwordhash` varchar(255) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `idlastlogon` bigint(20) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `hidden` bit(1) DEFAULT b'0',
  PRIMARY KEY (`iduser`),
  KEY `IDUSERUSERTYPE_idx` (`idusertype`),
  KEY `IDUSERLASTLOGON_idx` (`idlastlogon`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:15
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `userprofile`
--

DROP TABLE IF EXISTS `userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userprofile` (
  `iduserprofile` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) DEFAULT NULL,
  `nickname` varchar(45) DEFAULT NULL,
  `bio` varchar(2000) DEFAULT NULL,
  `motto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iduserprofile`),
  KEY `IDPROFILEUSER_idx` (`iduser`),
  CONSTRAINT `IDPROFILEUSER` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
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
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
) ENGINE=MyISAM AUTO_INCREMENT=213 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:15
CREATE DATABASE  IF NOT EXISTS `kure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `kure`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: skynet.from-ia.com    Database: kure
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
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertype` (
  `idusertype` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) DEFAULT NULL,
  `LibraryView` bit(1) DEFAULT b'0',
  `LibraryManage` bit(1) DEFAULT b'0',
  `PSAView` bit(1) DEFAULT b'0',
  `PSAEdit` bit(1) DEFAULT b'0',
  `GrantView` bit(1) DEFAULT b'0',
  `GrantEdit` bit(1) DEFAULT b'0',
  `ManageUsers` bit(1) DEFAULT b'0',
  `PlaylistEditor` bit(1) DEFAULT b'0',
  `EditPermissions` bit(1) DEFAULT b'0',
  `EditUserType` bit(1) DEFAULT b'0',
  `OnAirSignOn` bit(1) DEFAULT b'0',
  `ReviewMusic` bit(1) DEFAULT b'0',
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idusertype`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-21 21:11:18
