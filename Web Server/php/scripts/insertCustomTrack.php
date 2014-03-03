<?php

include_once('../publisher.php');
include_once('../library/LibraryEditor.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );

//Inserts a custom track

try
{
	$UserID = $_GET['UserID'];
	$TrackName = $_GET['TrackName'];
	$ReleaseDate = $_GET['ReleaseDate'];
	$FCC = $_GET['FCC'];
	$Recommended = $_GET['Recommended'];
	$PrimaryGenreID = $_GET['PrimaryGenreID'];
	$SecondaryGenreID = $_GET['SecondaryGenreID'];
	$ArtistID = $_GET['ArtistID'];
	$AlbumID = $_GET['AlbumID'];
	
	
	$track = new Track();
	$track->setName($TrackName);
	$track->setReleaseDate($ReleaseDate);
	$track->setFCC($FCC);
	$track->setRecommended($Recommended);
	$track->setPrimaryGenreID($PrimaryGenreID);
	$track->setSecondaryGenreID($SecondaryGenreID);
	$track->Artist = new Artist();
	$track->Artist->setID($ArtistID);
	$track->Album = new Album();
	$track->Album->setID($AlbumID);
	
	$editor = new LibraryEditor();
	
	$result = $editor->insertCustomTrack($track);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>