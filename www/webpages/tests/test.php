<?php
include_once ('../../php/sqlconnect.php');
include_once ('../../php/publisher.php');

try {
	$conn = new SqlConnect();
	echo $conn->callStoredProcJSON("getAllReaders", null);
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $_SESSION ['userid']);
	return false;
}

?>