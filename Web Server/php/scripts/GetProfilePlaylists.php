<?php

include_once ('../publisher.php');
include_once('../library/PlaylistManager.php');

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");
try {
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	$userID = $_SESSION['userid'];
	$manager = new PlaylistManager();
	$results = $manager->RetrieveProfilePlaylists($userID);
	echo JSON_ENCODE($results, JSON_PRETTY_PRINT);
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>
