<?php

	include('../classes/libraryBrowser.php');
	$browser = new libraryBrowser();

	$genre = $_GET['GenreID'];
	$reco = $_GET['Recommended'];

	$json_string = json_encode($browser->getFilterInfo($genre, $reco), JSON_PRETTY_PRINT);
	
	echo $json_string;

?>