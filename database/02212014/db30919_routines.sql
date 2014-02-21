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
	aEndDate datetime
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
	SET @GrantID = (SELECT g.idgrant FROM db30919.grant g
		WHERE g.name = aGrantName);
	IF(@GrantID IS NOT NULL) THEN
		#Check if it is enddated
		SET @prevEndDate = (SELECT g.enddate FROM db30919.grant g
			WHERE g.idgrant = @GrantID);
		IF(@prevEndDate IS NOT NULL) THEN
			UPDATE db30919.grant
				SET enddate = null;
		ELSE	
			UPDATE db30919.grant
				SET enddate = null, message = aGrantMessage, name = aGrantName;
		END IF;
	ELSE
		INSERT INTO db30919.grant(name, message, startdate, enddate, playcount)
			VALUES(aGrantName, aGrantMessage, current_timestamp, aEndDate, 0);
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
	CalledName varchar(45),
	CalledArtist varchar(45),
	CalledAlbum varchar(45),
	CalledPlayCount int,
	FCCFlag bit,
	CalledRecommended bit,
	ITunesID int,
	CalledReleaseDate date,
	CalledEndDate datetime,
	aPrimaryGenre varchar(45),
	aSecondaryGenre varchar(45),
	FilePath varchar(1023)
)
BEGIN
-- -----------------------------------
-- AddTrack
--  Created by Robert Clabough
--  Created 1/?/2014
--  Modified 2/14/2014 - rclabough
--	Modified 2/21/2014
--  	Removed inserts into genre table
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
		SET @PrimaryGenreID = (SELECT idGenre FROM db30919.genre WHERE Name = aPrimaryGenre);
		#IF(@PrimaryGenreID IS NULL) THEN
		#	INSERT INTO genre(Name) Values(aPrimaryGenre);
		#	SET @PrimaryGenreID = @@IDENTITY;
		#END IF;
	END IF;

	#SECONDARY GENRE
	IF(aSecondaryGenre IS NOT NULL) THEN
		SET @SecondaryGenreID = (SELECT idGenre FROM db30919.genre WHERE Name = aSecondaryGenre);
		#IF(@SecondaryGerneID IS NULL) THEN
		#	INSERT INTO genre(Name) Values(aSecondaryGenre);
		#	SET @SecondaryGenreID = @@IDENTITY;
		#END IF;
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
		INSERT INTO track(Name, idAlbum, idArtist, PlayCount, CreateDate, FCC, Recommended, ITLID, ReleaseDate, EndDate, Path, idPrimaryGenre, idSecondaryGenre) 
		Values(CalledName, @AlbumID, @ArtistID, CalledPlayCount, current_timestamp, FCCFlag, CalledRecommended, ITunesID, CalledReleaseDate, CalledEndDate, FilePath, @PrimaryGenre, @SecondaryGenre);
		SET @TrackID = @@IDENTITY;
	ELSE
		#If there is a track, update it be what I want
		UPDATE db30919.track
		SET Name = CalledName, CreateDate = current_timestamp, EndDate = CalledEndDate, ReleaseDate = CalledReleaseDate,
			FCC = FCCFlag, Recommended = CalledRecommended, ITLID = ITunesID, Path = FilePath, idPrimaryGenre = @PrimaryGenreID, idSecondaryGenre = @SecondaryGenreID
		WHERE idtrack = @TrackID;
		SELECT @TrackID as 'ID';
	END IF;
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
	aEndDate DateTime,
	aFirstName varchar(45),
	aLastName varchar(45),
	aUserTypeID int
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
		INSERT INTO user(idusertype, username, passwordhash, startdate, enddate, idlastlogon, firstname, lastname)
			VALUES(aUserTypeID, aUserName, aPasswordHash, current_timestamp, aEndDate, null, aFirstName, aLastName);
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
	SELECT idalbum as 'ID', Name as 'Album Name'
	FROM album;
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
	FROM db30919.album alb
	LEFT OUTER JOIN db30919.genre gOne ON alb.idPrimaryGenre = gOne.idgenre
	LEFT OUTER JOIN db30919.genre gTwo ON alb.idSecondaryGenre = gTwo.idgenre
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
	SELECT idGenre, Name FROM genre;
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
		trk.FCC, trk.Recommended, trk.ITLID, trk.Path, trk.PlayCount, 
		pgen.idgenre as 'PrimaryGenreID', pgen.Name as 'PrimaryGenre',
		sgen.idgenre as 'SecondGenreID', sgen.Name as 'SecondGenre'
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
/*!50003 DROP PROCEDURE IF EXISTS `GetAllTracksByGenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`u30919`@`%` PROCEDURE `GetAllTracksByGenre`(
	aGenreID int
)
BEGIN
	SELECT idArtist, idAlbum, Name, CreateDate, FCC, Recommended, PlayCount, idPrimaryGenre, idSecondaryGenre
	FROM track
	WHERE ((idPrimaryGenre = aGenreID) OR (idSecondaryGenre = aGenreID))
	AND (EndDate IS NULL OR EndDate < current_timestamp());
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
	FROM db30919.artist
	ORDER BY Name;
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
	SELECT idexceptionlog as 'ID', message, stacktrace, createdate, iduser
	FROM exceptionlog
	WHERE iduser = aUserID;
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
	SELECT trk.Name, trk.idtrack, play.PlayDate, play.idonairsession
	FROM db30919.playtrack play
	INNER JOIN db30919.track trk ON play.idtrack = trk.idtrack
	WHERE play.iduser = aUserID;
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
		trk.Recommended as 'Recommended', trk.PlayCount as 'PlayCount'
	FROM db30919.track trk
	INNER JOIN db30919.album alb ON trk.idalbum = alb.idalbum
	INNER JOIN db30919.artist art ON alb.idartist = art.idartist
	WHERE trk.idtrack >= aStartIndex
		AND trk.idtrack < (aStartIndex + aNumberToReturn)
		AND trk.EndDate IS NULL;
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
		trk.Recommended as 'Recommended', trk.PlayCount as 'PlayCount', trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM db30919.track trk
	INNER JOIN db30919.album alb ON trk.idalbum = alb.idalbum
	INNER JOIN db30919.artist art ON alb.idartist = art.idartist
	WHERE trk.Name > aLastWord
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
	FROM db30919.playtrack pltrk
	INNER JOIN db30919.user us ON pltrk.iduser = us.iduser
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
		trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM db30919.track trk
	INNER JOIN db30919.artist art ON trk.idartist = art.idartist
	WHERE idalbum = aAlbumID
	AND EndDate IS NULL;
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
		trk.PlayCount as 'Play Count', trk.idPrimaryGenre, trk.idSecondaryGenre
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
		trk.ReleaseDate as 'Release Date', trk.FCC as 'FCC', trk.Recommended as 'Recommended',
		trk.PlayCount as 'Play Count', trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM db30919.track trk
	INNER JOIN db30919.album alb ON trk.idalbum = alb.idalbum
	INNER JOIN db30919.artist art ON alb.idartist = art.idartist
	WHERE art.idartist = aArtistID
	AND trk.EndDate IS NULL;
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
		trk.ReleaseDate as 'Release Date', trk.FCC as 'FCC', trk.Recommended as 'Recommended',
		trk.PlayCount as 'Play Count', trk.idPrimaryGenre, trk.idSecondaryGenre
	FROM db30919.track trk
	INNER JOIN db30919.album alb ON trk.idalbum = alb.idalbum
	INNER JOIN db30919.artist art ON alb.idartist = art.idartist
	WHERE art.Name = aArtistName
	AND trk.EndDate IS NULL;
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
	aStackTrace varchar(1024)
)
BEGIN
	INSERT INTO errorlog(iduser, message, stacktrace)
		VALUES(aUserID, aMessage, aStackTrace);
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
	aStackTrace varchar(2048)
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
	INSERT INTO exceptionlog(message, stacktrace, createdate, iduser)
		VALUES(aMessage, aStackTrace, current_timestamp(), aUserID);
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

	#Insert the play into the track plays table
	INSERT INTO db30919.playtrack(idtrack, iduser, idonairsession, playdate)
		VALUES(aTrackID, aUserID, aOnAirSessionID, current_timestamp);
	#Update the playcount in the track table
	UPDATE db30919.track
		SET PlayCount = PlayCount + 1
		WHERE idtrack = aTrackID;
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
	aUserID int,
	aPasswordHash varchar(1024),
	aOnAirSession bit
)
BEGIN
-- --------------------------------------------------------------------------------
-- UserLogin
--
--  Created by Robert Clabough
--  2/18/2014
--
-- Checks the password hash against the one that is stored in the database.  If it is
-- true then it logs the user in by creating a new user session.  It will return 0 if successful
-- and 1 if there was an error.
-- --------------------------------------------------------------------------------
	#CHECK USER LOGIN
	SET @PasswordHash = (SELECT passwordhash FROM user WHERE iduser = aUserID);
	IF(@PasswordHash = aPasswordHash) THEN
		#SUCCESS
		#Return 0 for success, create a new entry in the sessions
		INSERT INTO usersession(iduser, logon) VALUES(aUserID, current_timestamp);
		UPDATE user SET idlastlogon = @@IDENTITY WHERE iduser = aUserID;
		
		#If the on air bit is set, then update the on air table as well
		IF(aOnAirSession = 1) THEN 
			INSERT INTO onairsession(iduser, logon) VALUES(aUserID, current_timestamp);
		END IF;
	END IF;

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

-- Dump completed on 2014-02-21 14:25:25
