<?php
include_once('../php/publisher.php');
// Fatal error handler for PHP
register_shutdown_function("Publisher::fatalHandler");

try {
	echo 'This is an Exception thrower.  This script throws an exception to be caught as most should be.';
	echo 'Exception is thrown right after this line.';
	
	throw new Exception('Test Exception from ExceptionThrower.php');
}
catch (Exception $e) {
	echo 'Exception Caught';
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), '5');
	echo 'Exception Published';
	return false;
}

?>
