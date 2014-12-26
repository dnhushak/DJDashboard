<?php
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
	$PsaID = $_GET['psaid'];
	$UserID = $_SESSION['userid'];
	//If we don't get a count, only return one (I'm not goign to return all)

	$manager = new PSAManager();
	$results = $manager->getPSASpecificInfo($PsaID);
	echo JSON_ENCODE($results, JSON_PRETTY_PRINT);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}
?>