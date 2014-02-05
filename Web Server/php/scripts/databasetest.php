<?php
include '../library/LibraryManager.php';
	$conn = new LibraryManager();
	$array = $conn->GetAllArtists(true);
	$length = count($array);
	for ($i = 0; $i < $length; $i++) 
	{
		print $array[$i]->getName() . "<br>";
	}
		

?>