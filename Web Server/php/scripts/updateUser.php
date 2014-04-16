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
	
	$userID = $_GET['UserID'];
	$first = $_GET['FirstName'];
	$last = $_GET['LastName'];
	$email = $_GET['Email'];
	$type = $_GET['TypeID'];

	$result = $manager->UpdateUser($userID, $first, $last, $email, $type);
	echo $result;
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>