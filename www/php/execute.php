<?php
include_once './sqlconnect.php';
include_once './publisher.php';

// Change to true if using execute directly in a browser window
$debug = false;

// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");

// Check if logging in, if yes, bypass session variable check
// Route to proc call function
// Compare command against permissions (associative array?) in session variables
// Collect POST/GET args, arrange in array

// Attempt to execute the stored procedure
try {
	$conn = new SqlConnect();
	if ($debug) {
		echo "<br><br><br>";
	}
	$args = array ();
	
	// Run through each variable passed in via the POST method.
	foreach ($_POST as $param_name => $param_val) {
		// Check if the given parameter name 
		if ($param_name != "command") {
			$args [] = $param_val;
		}
		// Convert all of the argument names into a php variable, and set its value equal to the passed in value
		$$param_name = $param_val;
		
		if ($debug) {
			// Print all of the parameters and their values
			echo "POST Param: $param_name; Value: $param_val<br />\n";
		}
	}
	
	if ($debug) {
		echo "<br><br><br>";
	}
	
	// Run through each variable passed in via the GET method. This should only be used for testing purposes
	foreach ($_GET as $param_name => $param_val) {
		if ($param_name != "command") {
			$args [] = $param_val;
		}
		// Convert all of the argument names into a php variable, and set its value equal to the passed in value
		$$param_name = $param_val;
		if ($debug) {
			// Print all of the parameters and their values
			echo "GET Param: $param_name; Value: $param_val<br />\n";
		}
	}
	
	if ($debug) {
		echo "<br><br><br>";
	}
	
	$results = $conn->callStoredProcJSON($command, $args);
	echo $results;
}
catch (Exception $e) {
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), 0);
	return false;
}

?>