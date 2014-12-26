<?php

/*
 * Created on Apr 1, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
include_once ('../admin/ProfileManager.php');
include_once ('../publisher.php');

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");
try {
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	$manager = new ProfileManager();

	$djArr = $manager->getDJs();
	echo JSON_ENCODE($djArr3);
} catch (Exception $e) {
	Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}
?>
