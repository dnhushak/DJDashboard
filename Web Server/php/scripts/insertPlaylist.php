<?php
include('../Library/PlaylistManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );


try
{
	$UserID = $_GET['UserID'];
	$PlaylistName = $_GET['PlaylistName'];
	
	//decode json, not working
	$json = json_decode($input);  
	echo $UserID;
	echo $PlaylistName;
	//var_dump($TrackArray);
	//Make a list of track IDs, 
	//{1, 2, 3, 4, 5}, nothing else needs to be sent
	
	$result = PlaylistManager::CreatePlaylist($UserID, $TrackArray, $PlaylistName);
	echo $result;
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>