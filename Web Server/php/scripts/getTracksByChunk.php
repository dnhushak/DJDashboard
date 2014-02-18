<?php

	include('../classes/libraryBrowser.php');
	$browser = new libraryBrowser();

	$lastTrack;
	if(isset($_GET['LastTrack'])){
		$lastTrack = $_GET['LastTrack'];
	}else{
		$lastTrack = "";
	}
	
	$json_string = json_encode($browser->getTrackChunk(array($lastTrack)), JSON_PRETTY_PRINT);

	echo $json_string;

?>