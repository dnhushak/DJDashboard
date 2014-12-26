<?php
include_once('../psagrant/GrantManager.php');
include_once('../publisher.php');



register_shutdown_function( "Publisher::fatalHandler" );

try
{
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	$UserID = $_SESSION['userid'];
	$GrantID = $_GET['grantid'];
	//If we don't get a count, only return one (I'm not goign to return all)

	$manager = new GrantManager();
	$results = $manager->getGrantAllInfo($GrantID);
	
	echo JSON_ENCODE($results, JSON_PRETTY_PRINT);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}
?>