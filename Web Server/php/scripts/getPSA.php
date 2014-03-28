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
	$count = $_GET['Count'];
//If we don't get a count, only return one (I'm not goign to return all)
	if($count == null)
	{
		$count = 1;
	}
	$manager = new PSAManager();
	$results = $manager->getPSAs($count);
	echo JSON_ENCODE($results, JSON_PRETTY_PRINT);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>
