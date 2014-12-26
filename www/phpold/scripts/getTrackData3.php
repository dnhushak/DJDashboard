<?php
include_once '../sqlconnect.php';

$TrackID = $_GET ['TrackID'];

$conn = new SqlConnect();
$results = $conn->callStoredProc("GetAllTrackData", $TrackID);

$arr = array ();
while ($row = $results->fetch_array(MYSQL_ASSOC)) {
	$arr [] = $row;
}

echo json_encode($arr [0], JSON_PRETTY_PRINT);

?>