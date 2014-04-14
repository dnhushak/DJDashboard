<?php
/*
 * Created on Mar 19, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
  include_once('../psagrant/PSAManager.php');
 include_once('../publisher.php');
 
 //disable recording because i don't care if we don't get a count.
 
error_reporting(0);
	
register_shutdown_function( "Publisher::fatalHandler" );
 
 try
{
	if (session_status() == PHP_SESSION_NONE) {
	    session_start();
	}
	$UserID = $_SESSION['userid'];
	$OnAirSessionID = $_SESSION['onairsessionid'];
	$psaid = $_GET['PSAID'];

	$manager = new PSAManager();
	$results = $manager->playPSA($psaid, $UserID, $OnAirSessionID);
	echo JSON_ENCODE($results, JSON_PRETTY_PRINT);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>
