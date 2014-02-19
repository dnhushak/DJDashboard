<?php
include_once('../Publisher.php');

$Message = $_GET['Message'];
$stacktrace = $_GET['StackTrace'];
$userID = $_GET['userID'];

$results = Publisher::publishException($stacktrace, $Message, $userID);



?>