<?php
include('../Library/PlaylistManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );


try
{
	$UserID = $_GET['UserID'];
	$pman = new PlaylistManager();
	$result = $pman->RetrieveAllPlaylistsByUserID($UserID);
	var_dump($result);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>