<?php
include('../Library/PlaylistManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );

try
{
	if(session_status() == PHP_SESSION_NONE) {
	    session_start();
	}
	$UserID = $_SESSION['userid'];
	
	$result = PlaylistManager::RetrievePlaylistIDsByUserID($UserID);
	echo json_encode($result);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>