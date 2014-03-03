<?php
include_once('../publisher.php');

//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );

$arr = Publisher::getLatestExceptions();
echo json_encode($arr, JSON_PRETTY_PRINT);

?>