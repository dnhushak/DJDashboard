<?php

include_once('../publisher.php');
include_once('../library/LibraryManager.php');

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
	
	
	$track = new Track();
	$track->setName($TrackName);
	$track->setReleaseDate($ReleaseDate);
	$track->setFCC($FCC);
	$track->setRecommended($Recommended);
	$track->setPrimaryGenreID($PrimaryGenreID);
	$track->setSecondaryGenreID($SecondaryGenreID);
	
	var_dump($track);
	
	$result = PlaylistManager::CreatePlaylist($UserID, $Tracks, $PlaylistName);
	echo $result;
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>