<?php

	include('../library/libraryManager.php');
	$manager = new libraryManager();

	$lastTrack;
	if(isset($_GET['LastTrack'])){
		$lastTrack = $_GET['LastTrack'];
	}else{
		$lastTrack = 0;
	}
	$chunkSize;
	if(isset($_GET['ChunkSize'])){
		$chunkSize = $_GET['ChunkSize'];
	}else{
		$chunkSize = 150;
	}
	
	$json_string = json_encode($manager->getTrackChunks($lastTrack, $chunkSize), JSON_PRETTY_PRINT);

	echo $json_string;

?>