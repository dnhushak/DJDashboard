<?php


include('../psagrant/PSAManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );


try
{
	if (session_status() == PHP_SESSION_NONE) {
	    session_start();
	}
 	$UserID = $_SESSION['userid'];
	$PSAName = $_GET['PSAName'];
	$PSAMessage = $_GET['PSAMessage'];
	$PSAEndDate = $_GET['PSAEndDate'];
	
	$psa = new PublicServiceAnnouncement();
	$psa->setName($PSAName);
	$psa->setMessage($PSAMessage);
	$psa->setEndDate($PSAEndDate);
	
	$psaManage = new PSAManager();
	$id = $psaManage->addPSA($psa);
	echo $id;
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}
	
 
?>
