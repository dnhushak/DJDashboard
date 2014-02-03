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
-- Dumping routines for database 'db30919'
--
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
	CalledName varchar(45),
	CalledArtist varchar(45),
	CalledAlbum varchar(45),
	CalledPlayCount int,
	FCCFlag bit,
	CalledRecommended bit,
	ITunesID int,
	CalledReleaseDate date,
	CalledEndDate datetime,
	FilePath varchar(1023)
)
BEGIN
	#Fetch ArtistID, Add artist if not found
	SET @ArtistID = (SELECT art.idArtist FROM artist art WHERE art.Name = CalledArtist);
	IF(@ArtistID IS NULL) then
		INSERT INTO artist(Name) VALUES(CalledArtist);
		SET @ArtistID = @@IDENTITY;
	END IF;

	SET @AlbumID = (SELECT alb.idalbum FROM album alb WHERE alb.Name = CalledAlbum AND alb.idArtist = @ArtistID);
	IF(@AlbumID IS NULL) THEN
		INSERT INTO album(Name, idArtist) Values(CalledAlbum, @ArtistID);
		SET @AlbumID = @@IDENTITY;
	END IF;

	#Add the track based on ArtistID and AlbumID
	#Variables: CalledName, CalledArtist, CalledAlbum, CalledPlayCount, FCCFlag, Recommended, ITunesID, ReleaseDate, EndDate (Some can be null)
	SET @TrackID = (SELECT trk.idTrack FROM track trk WHERE trk.idArtist = @ArtistID AND trk.idAlbum = @AlbumID AND Name = CalledName);
	IF(@TrackID IS NULL) then
		INSERT INTO track(Name, idAlbum, idArtist, PlayCount, CreateDate, FCC, Recommended, ITLID, ReleaseDate, EndDate, Path) 
		Values(CalledName, @AlbumID, @ArtistID, CalledPlayCount, current_timestamp, FCCFlag, CalledRecommended, ITunesID, CalledReleaseDate, CalledEndDate, FilePath);
		SET @TrackID = @@IDENTITY;
	ELSE
		#If there is a track, update it be what I want
		UPDATE db30919.track
		SET Name = CalledName, CreateDate = current_timestamp, EndDate = CalledEndDate, ReleaseDate = CalledReleaseDate,
			FCC = FCCFlag, Recommended = CalledRecommended, ITLID = ITunesID, Path = FilePath
		WHERE idtrack = @TrackID;
		SELECT @TrackID as 'ID';
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
	aPlaylistEdit bit,
	aEditPermissions bit,
	aEditUserType bit,
	aOnAirSignon bit
)
BEGIN
	SET @usertypeID = (SELECT idUserType FROM db30919.usertype 
		where LibraryView = aLibraryView
		AND LibraryManage = aLibraryManage
		AND PSAView = aPSAView
		AND PSAEdit = aPSAEdit
		AND GrantView = aGrantView
		AND GrantEdit = aGrantEdit
		AND ManageUsers = aManageUsers
		AND PlaylistEditor = aPlaylistEdit
		AND EditPermissions = aEditPermissions
		AND EditUserType = aEditUserType
		AND OnAirSignon = aOnAirSignon );

	#usertypeID should be null, if it is not then there is already a usertype with those permissions

	IF(@usertypeID IS NOT NULL) THEN
		SELECT @usertypeID as 'Type ID';
	ELSE 
		INSERT INTO db30919.usertype(typename, LibraryView, LibraryManage, PSAView, PSAEdit, GrantView, GrantEdit, ManageUsers, PlaylistEditor, EditPermissions, OnAirSignon)
			VALUES(aUserTypeName, aLibraryView, aLibraryManage, aPSAView, aPSAEdit, aGrantView, aGrantEdit, aManageUsers, aPlaylistEdit, aEditPermissions, aOnAirSignon);
		SELECT @@IDENTITY as 'Type ID';

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
	SELECT idAlbum as 'ID', Name as 'Album'
	FROM db30919.album
	WHERE idArtist = aArtistID;
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
	SET @ArtistID = (SELECT idArtist FROM db30919.artist WHERE Name = aArtistName);

	IF (@ArtistID IS NULL) THEN
	SELECT 'Error, no results found' as 'Error';

	ELSE
	SELECT idAlbum as 'ID', Name as 'Album Name'
	FROM db30919.album
	WHERE idArtist = @ArtistID;
	END IF;
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
	FROM db30919.artist;
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
		trk.ReleaseDate as 'Release Date', trk.FCC as 'FCC', trk.Recommended as 'Recommended',
		trk.PlayCount as 'Play Count'
	FROM db30919.track trk
	INNER JOIN db30919.album alb ON trk.idalbum = alb.idalbum
	WHERE alb.Name = aAlbumName
	AND trk.EndDate IS NULL;
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

-- Dump completed on 2014-02-03 13:36:37
