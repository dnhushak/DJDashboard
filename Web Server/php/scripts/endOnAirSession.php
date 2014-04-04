<?php
/*
 * Created on Apr 4, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 include_once('../publisher.php');
 include_once ('../sqlconnect.php');
if (session_status() == PHP_SESSION_NONE) {
	session_start();}
	if ($_SESSION['sessionid'] != null) {
		try {
			$conn = new SqlConnect();

			$results;
			// Get all information by username
			$arr = array ();
			$arr[] = $_SESSION['userid'];
			$arr[] = $_SESSION['onairid'];
			$results = $conn->callStoredProc("OnAirLogout", $arr);

			unset($_SESSION['onairid']);
			if ($results == false) {
				Publisher :: publishException('index.php', 'Error in resultset from OnAirLogout', $_SESSION['userid']);
			}
			
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), $_SESSION['userid']);
			return false;
		}
	}
	
?>
