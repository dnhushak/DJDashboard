<?php
include_once('../Publisher.php');

$Message = $_GET['Message'];
$stacktrace = $_GET['StackTrace'];

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
$userid = $_SESSION['userid'];

$results = Publisher::publishException($stacktrace, $Message, $userID);



?>