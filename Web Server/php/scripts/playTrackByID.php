<?php
include('../library/LibraryManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
	register_shutdown_function( "Publisher::fatalHandler" );
try
{
	$manager = new LibraryManager();
	$TrackID = $_GET['TrackID'];
	$UserID = 0; //TODO
	$OnAirSessionID = 0; //TODO
	$result = $manager->PlayTrack($UserID, $TrackID, $OnAirSessionID);
	echo $result;
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), 0);
	return false;
}

?>