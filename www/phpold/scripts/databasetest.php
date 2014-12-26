<?php
include '../library/LibraryManager.php';
	$conn = new LibraryManager();
	$array = $conn->GetAllArtists(true);
	$length = count($array);
	for ($i = 0; $i < $length; $i++) 
	{
		print $array[$i]->getName() . "<br>";
	}
		
	$j = json_encode((array)$array[0]);
	echo $j."<br>";
	
	$j = ($array[1]->jEncode());
	echo $j."<br>";
?>