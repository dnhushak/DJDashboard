<?php
include('../publisher.php');

$UserID = filter_input(INPUT_POST, 'UserID', FILTER_VALIDATE_INT);

$json_string = json_encode(Publisher::getExceptionsByUser($UserID, JSON_PRETTY_PRINT));

echo $json_string;

?>