<?php
include_once ('../Library/UserManager.php');
include_once ('../publisher.php');

register_shutdown_function("Publisher::fatalHandler");
try {
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	$manager = new UserManager();

	$users = $manager->getAllUserTypes();
	echo JSON_ENCODE($users, JSON_PRETTY_PRINT);
} catch (Exception $e) {
	Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}

?>