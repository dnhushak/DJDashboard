<?php

final class libraryBrowser {
	private $database = 'db30919';
	private $username = 'u30919';
	private $password = 'pkMDpK6Rh';
	private $hostname = 'mysql.cs.iastate.edu';
	private $db;
	private $playlist;
	private $artist;
	private $album;
	private $json;

	public function __construct(){
		$this->db = new mysqli($this->hostname, $this->username, $this->password, $this->database);
		if ($this->db->connect_errno > 0) {
			die('Unable to connect to database [' . $db->connect_error . ']');
		}
	}

	public function __destruct(){
	}

	public function getArtists(){
		if ($this->playlist == "All") {
			$sql = "CALL db30919.GetArtistList()";
			// $sql = "SELECT * FROM db30919.artist";
			echo $sql . "<br/>";
			if (!$result = $this->db->query($sql)) {
				die('There was an error running the query [' . $db->error . ']');
			}
			// $db_class -> getArtists();
			// var_dump($result);
			// echo "<br/>";
			$i = 0;
			while ($row [$i] = mysqli_fetch_assoc($result)) {
				echo $row [$i] [ID] . " : " . $row [$i] [Artist] . "<br/>";
				$i++;
				// var_dump($row);
			}
			// var_dump($array);
			$this->json = json_encode($row);
		}
	}

	public function setPlaylist($playlist){
		$this->playlist = $playlist;
	}
	// $json_string = json_encode($data, JSON_PRETTY_PRINT);
	// }
	public function getPlaylist(){
		return $this->playlist;
	}

	public function getJson(){
		return $this->json;
	}
}
?>