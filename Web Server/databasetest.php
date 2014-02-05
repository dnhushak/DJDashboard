<?php
include 'library\LibraryManager.php';
	echo "Start";
	$conn = new LibraryManager();
	$array = $conn->GetAllArtists(false);
	
	
	
	
		
		$length = count($array);
		for ($i = 0; $i < $length; $i++) 
		{
			print $array[$i]->getName() . "<br>";
			/**
			$albArr = $array[$i]->getAlbums();
			for($j = 0; $j < count($albArr); $j++)
			{
				print "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" . $albArr[$j]->getName() . "<br>";
			}
			**/
			
		
		}
			
?>