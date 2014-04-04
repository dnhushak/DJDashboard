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

	if(!($manager->IsOnAir())){
		echo json_encode(array("errorMessage" => "Another user has logged on and you have been kicked off",
								"error" => "Validation Error"));
		die();
	}
	$TrackID = $_GET ['TrackID'];
	$UserID = $_SESSION ['userid'];
	$OnAirSessionID = 0;//$_SESSION['onairid'];
	$result = $manager->PlayTrack($UserID, $TrackID, $OnAirSessionID);
	echo json_encode(array("PlayID" => $result)); //Echo the final ID to send back to frontend
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}	

?>