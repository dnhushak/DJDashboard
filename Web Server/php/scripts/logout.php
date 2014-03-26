<?php
include_once('../library/UserManager.php');
include_once('../publisher.php');

//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );
$sessionid = $_POST['sessionid'];


try {
	
		UserManager::endSession($sessionid);
		echo('Logout Success');
	
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), null);
	return false;
}

?>