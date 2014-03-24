<?php
include ('../library/LibraryManager.php');
include_once ('../publisher.php');

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");
try {
	$manager = new LibraryManager();
	$TrackID = $_GET ['TrackID'];
	$UserID = $_SESSION ['userid'];
	$OnAirSessionID = $_SESSION['onairid'];
	$result = $manager->PlayTrack($UserID, $TrackID, $OnAirSessionID);
	echo json_encode($result); //Echo the final ID to send back to frontend
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}	

?>