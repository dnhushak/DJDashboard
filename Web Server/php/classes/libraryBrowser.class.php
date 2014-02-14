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
	}

	public function getTracksByAlbum(){
	}
	// Returns a two layered array of albums. It's an array of arrays, with the sub-arrays being a two-item associative array including "ID" and "Name"
	public function getAlbumsByArtist($ArtistID){
		$albumArray = $this->manager->GetAlbumsByID($ArtistID);
		$ret = array ();
		foreach ($albumArray as $album) {
			$albumRow = array (
					ID => $album->getID(),
					Name => $album->getName() );
			$ret [] = $albumRow;
		}
		return $ret;
	}

	public function getArtists($ArtistID){
	}
}
?>