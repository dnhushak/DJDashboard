<?php


include('../psagrant/GrantManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );


try
{
	if (session_status() == PHP_SESSION_NONE) {
	    session_start();
	}
 	$UserID = $_SESSION['userid'];
	$GrantID = $_GET['GrantID'];
	$GrantName = $_GET['Name'];
	$Message = $_GET['Message'];
	$EndDate = $_GET['EndDate'];
	$PlayCount = $_GET['PlayCount'];
	$MaxPlayCount = $_GET['MaxPlayCount'];
	$grant = new Grant();
	$grant->setGrantID($GrantID);
	$grant->setGrantName($GrantName);
	$grant->setMessage($Message);
	$grant->setEndDate($EndDate);
	$grant->setPlayCount($PlayCount);
	$grant->setMaxPlayCount($MaxPlayCount);
	
	$manager = new GrantManager();
	$id = $manager->addGrant($grant, $UserID);
	
	echo $id;
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}
	
 
?>
