<?php
include_once ('../library/LibraryManager.php');

final class libraryBrowser {
	private $json;
	private static $chunksize;
	private $manager;

	public function __construct(){
		$this->manager = new LibraryManager();
	}

	public function __destruct(){
	}

	public function getTracksByArtist($ArtistID){
		$trackArray = $this->manager->GetTracksByArtist($ArtistID);
		$ret = array ();
		foreach ($trackArray as $track) {
			$trackRow = array (
					"ID" => $track->getID(),
					"Name" => $track->getName(),
					"Album" => $track->getAlbum() );
			$ret [] = $trackRow;
		}
		return $ret;
	}

	public function getTracksByAlbum($AlbumID){
		$trackArray = $this->manager->GetTracksByAlbum($AlbumID);
		$ret = array ();
		foreach ($trackArray as $track) {
			$trackRow = array (
					"ID" => $track->getID(),
					"Name" => $track->getName() );
			$ret [] = $trackRow;
		}
		return $ret;
	}
	
	// Returns a two layered array of albums.
	// It's an array of arrays, with the sub-arrays being a two-item associative array including "ID" and "Name"
	public function getAlbumsByArtist($ArtistID){
		$albumArray = $this->manager->GetAlbumsByID($ArtistID);
		$ret = array ();
		foreach ($albumArray as $album) {
			$albumRow = array (
					"ID" => $album->getID(),
					"Name" => $album->getName() );
			$ret [] = $albumRow;
		}
		return $ret;
	}

	public function getArtists($ArtistID){
	}
}
?>