<?php
include ('../library/LibraryManager.php');
include_once ('../publisher.php');

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");
try {
	$manager = new LibraryManager();
	$PlayID = $_GET ['PlayID'];
	$TrackID = $_GET ['TrackID'];
	$UserID = $_SESSION ['userid'];
	$UserID= null;
	$result = $manager->UpdatePlay($PlayID, $TrackID, $UserID);
	echo $result;
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>