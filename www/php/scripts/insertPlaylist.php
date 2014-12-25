<?php
include('../library/PlaylistManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );


try
{
	if (session_status() == PHP_SESSION_NONE) {
	    session_start();
	}
	$UserID = $_SESSION['userid'];
	$PlaylistName = $_GET['PlaylistName'];
	$Tracks = $_GET['Tracks'];
	
	
	
	$result = PlaylistManager::CreatePlaylist($UserID, $Tracks, $PlaylistName);
	echo $result;
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>