<?php

	include('../classes/libraryBrowser.php');
	$browser = new libraryBrowser();

	$genre = $_GET['GenreID'];
	
	$json_string = json_encode($browser->getTracksByGenre(array($genre)), JSON_PRETTY_PRINT);

	echo $json_string;

?>