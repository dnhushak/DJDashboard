<?php

include ('../library/LibraryManager.php');
include_once ('../publisher.php');

// Fatal error handler for PHP
//register_shutdown_function("Publisher::fatalHandler");
try {

	$manager = new LibraryManager();
	$userID = $_GET ['UserID'];
	$startDate = $_GET['StartDate'];
	$endDate = $_GET['EndDate'];

	$startDate .= " 00:00:00";
	$endDate .= " 23:59:59";

	$result = $manager->getAlbumPlaysByTimeSpanAndUserID($startDate, $endDate, $userID);
	echo json_encode($result, JSON_PRETTY_PRINT);
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>