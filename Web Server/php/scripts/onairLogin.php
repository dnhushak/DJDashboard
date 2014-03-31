<?php

include ('../library/UserManager.php');
include_once ('../publisher.php');

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");
try {
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	$manager = new UserManager();
	$result = $manager->startOnAirSession();
	var_dump($result);
	$_SESSION['onairid'] = $result;
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>