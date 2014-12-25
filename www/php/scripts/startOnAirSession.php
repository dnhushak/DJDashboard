<?php
/*
 * Created on Mar 28, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 //Starts the on air session
 	//BASED ENTIRELY ON SESSION VARIABLES
 	
 	include_once('../publisher.php');
 	include_once('../library/UserManager.php');
 	
 	// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");
 	
 	if (session_status() == PHP_SESSION_NONE) {
		    session_start();
		}
 	
 	if($_SESSION['userid'] == null)
 	{
 		Publisher::publishUserError(0, 'startOnAirSession.php', 'Unknown user tried starting on air session');
 		return;
 	}
 	if($_SESSION['userid'] != null && $_SESSION['ponairsignon'] == "0")
 	{
 		Publisher::publishUserError($_SESSION['userid'], 'startOnAirSession.php', 'User tried logging in who does not have on air permissions; '.$_SESSION['ponairsignon'].' JSON '.JSON_ENCODE($_SESSION));
 		return;
 	}
 	if($_SESSION['userid'] != null && $_SESSION['ponairsignon'])
 	{
 		//Success, we can log in
 		$manager = new UserManager();
 		return $manager->startOnAirSession();
 	}
?>
