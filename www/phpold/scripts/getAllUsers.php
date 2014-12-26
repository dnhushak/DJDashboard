<?php
include_once ('../admin/ProfileManager.php');
include_once ('../publisher.php');
include_once ('../sqlconnect.php');

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");
try {
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	
	$conn = new SqlConnect();
	$results = $conn->callStoredProcArr("GetAllUsers", null);
	echo json_encode($results, JSON_PRETTY_PRINT);
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}
?>
