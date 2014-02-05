<?php

$sql = "SELECT track.*, album.Name as 'Album Name', artist.Name as 'Artist Name'
		FROM track 
		INNER JOIN album 
		ON track.idalbum= album.idalbum 
		INNER JOIN artist 
		ON track.idartist = artist.idartist
		ORDER BY Name;";

$connection = new mysqli("mysql.cs.iastate.edu", "u30919", "pkMDpK6Rh", "db30919");

$tracks = $connection->query($sql);
$songs = array();
 foreach( $tracks as $song) {
 	// echo $song["Recommended"] . " " . $song["Name"] . " " . $song["Artist Name"] . " " . $song["Album Name"] . " " . "GENERE" . " " . $song["PlayCount"] . " " . $song["FCC"] . " " . $song["ReleaseDate"];;
 	// echo  "<br>";
 	array_push($songs, $song);
 }
echo json_encode($songs);
?>