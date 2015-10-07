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
// 	echo "<br><br><br>";
	$args = array ();
	foreach ($_POST as $param_name => $param_val) {
		if ($param_name != "command") {
			$args [] = $param_val;
		}
		$$param_name = $param_val;
// 		echo "Param: $param_name; Value: $param_val<br />\n";
	}
// 	echo "<br><br><br>";
	foreach ($_GET as $param_name => $param_val) {
		if ($param_name != "command") {
			$args [] = $param_val;
		}
		$$param_name = $param_val;
// 		echo "Param: $param_name; Value: $param_val<br />\n";
	}
// 	echo "<br><br><br>";
	
	$results = $conn->callStoredProcJSON($command, $args);
	echo $results;
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), 0);
	return false;
}

?>