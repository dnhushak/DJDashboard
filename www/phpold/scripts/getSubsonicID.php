<?php
include ('../library/LibraryManager.php');
include_once ('../publisher.php');

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");
try {
	
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	
	$manager = new LibraryManager();
	$UserID = $_SESSION ['userid'];
	$trackID = $_GET ['TrackID'];
	$result = $manager->getSubsonicID($trackID);
	echo json_encode($result, JSON_PRETTY_PRINT);
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>