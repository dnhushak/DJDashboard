<?php
/*
 * Created on Feb 28, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
include_once('../library/LibraryManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );
 
 	$TrackLike = $_GET['TrackLike'];
 	try
 	{
 	$manager = new LibraryManager();
 	
 	$results = $manager->GetTracksLike($TrackLike);
 	
 	echo json_encode($results);
 	
 	}
	catch (Exception $e)
	{
		Publisher::publishException($e->getTraceAsString(), $e->getMessage(), 0);
		return false;
	}
 	
?>
