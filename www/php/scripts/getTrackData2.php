<?php
include_once '../sqlconnect.php';

$TrackID = $_GET ['TrackID'];

$conn = new SqlConnect();
$results = $conn->callStoredProcJSON("GetAllTrackData", array (
		$TrackID ));

echo $results;

?>