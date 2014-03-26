<?php
include_once('../library/userManager.php');
include_once('../publisher.php');

//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );
if (session_status() == PHP_SESSION_NONE) {
	session_start();
}
try {
	if($_SESSION['sessionid'] != null)
	{
		UserManager::endSession($_SESSION['sessionid']);
	}
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>