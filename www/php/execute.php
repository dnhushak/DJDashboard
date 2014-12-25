<?php
include_once './sqlconnect.php';
include_once './publisher.php';

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");

// Check if logging in, if yes, bypass session variable check
// Route to proc call function
// Compare command against permissions (associative array?) in session variables
// Collect POST/GET args, arrange in array
//

try {
	$conn = new SqlConnect();
	echo "<br><br><br>";
	foreach ($_POST as $param_name => $param_val) {
		$$param_name = $param_val;
		echo "Param: $param_name; Value: $param_val<br />\n";
	}
	echo "<br><br><br>";
	foreach ($_GET as $param_name => $param_val) {
		$$param_name = $param_val;
		echo "Param: $param_name; Value: $param_val<br />\n";
	}
	echo "<br><br><br>";
	$commandArr = array ();
	$commandArr [getTrackData] = "GetAllTrackData";
	
	$command = $_GET ['command'];
	
	$TrackID = $_GET ['TrackID'];
	
	echo $commandArr [$command];
	$results = $conn->callStoredProcArr($commandArr [$command], $TrackID);
	
	echo json_encode($results);
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), 0);
	return false;
}

?>