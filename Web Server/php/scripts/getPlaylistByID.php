<?php
include('../library/PlaylistManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );


try
{
	$PlaylistID = $_GET['PlaylistID'];
	$pman = new PlaylistManager();
	$result = $pman->RetrievePlaylistByID($PlaylistID);
	echo json_encode($result, JSON_PRETTY_PRINT);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>