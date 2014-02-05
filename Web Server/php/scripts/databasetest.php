<?php
include '../library/LibraryManager.php';
	$conn = new LibraryManager();
	$array = $conn->GetAllArtists(false);
	
	
	
	
		
		$length = count($array);
		for ($i = 0; $i < $length; $i++) 
		{
			print $array[$i]->getName() . "<br>";
		
		}
		
		$albArr = $array[700]->getAlbums();
		for($j = 0; $j < count($albArr); $j++)
		{
			print "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" . $albArr[$j]->getName() . "<br>";
		}
		
		$trkArr = $albArr[0]->getTracks();
		echo "Tracks : <br>Count: ".count($trkArr)."<br><br>";
		
		for($j = 0; $j < count($trkArr); $j++)
		{
			print "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" . $trkArr[$j]->getName() . "<br>";
		}	
?>