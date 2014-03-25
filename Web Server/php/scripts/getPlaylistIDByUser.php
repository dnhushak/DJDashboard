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
	
	//Changed to not use statically
	$manager = new PlaylistManager();
	$result = $manager->RetrievePlaylistIDsByUserID($UserID);
	echo json_encode($result);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>