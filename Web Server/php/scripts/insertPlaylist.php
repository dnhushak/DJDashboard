<?php
include('../Library/PlaylistManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );


try
{
	$UserID = $_GET['UserID'];
	$PlaylistName = $_GET['PlaylistName'];
	//Temporary
	$TrackArray = array();
	for($i = 0; $i < 1000; $i += 100)
	{
		$TrackArray[] = $i;
	}
	echo $UserID;
	echo $PlaylistName;
	var_dump($TrackArray);
	$result = PlaylistManager::CreatePlaylist($UserID, $TrackArray, $PlaylistName);
	echo $result;
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>