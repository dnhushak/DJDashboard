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
	$UserID = $_SESSION['userid'];
	
	$psa = new PublicServiceAnnouncement();
	$psa->setMessage($_GET['Message']);
	$psa->setName($_GET['Name']);
	$psa->setSponsor($_GET['Sponsor']);
	$psa->setID($_GET['psaid']);
	$psa->setPlayCount($_GET['PlayCount']);
	$psa->setMaxPlayCount($_GET['MaxPlayCount']);
	$psa->setEndDate($_GET['EndDate']);
	
	
	
	//If we don't get a count, only return one (I'm not goign to return all)

	$manager = new PSAManager();
	$results = $manager->addPSA($psa);
	echo JSON_ENCODE($results, JSON_PRETTY_PRINT);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}
?>