<?php

/*
 * Created on Apr 4, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */

include_once ('../publisher.php');
include_once ('../admin/ProfileManager.php');
if (session_status() == PHP_SESSION_NONE) {
	session_start();
}

try {
	if ($_SESSION['userid'] != null) {
		$manager = new ProfileManager();
		$result = $manager->getProfile($_SESSION['userid']);
		echo(JSON_ENCODE($result, JSON_PRETTY_PRINT));
	} else {
		throw new Exception('Session not set!');
	}
} catch (Exception $e) {
	Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), $_SESSION['userid']);
	return false;
}
?>
