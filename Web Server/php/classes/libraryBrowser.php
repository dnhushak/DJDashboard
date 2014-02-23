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
					"ID" => utf8_encode($track->getID()),
					"Name" => utf8_encode($track->getName()),
					"Album" => utf8_encode($track->getAlbum()),
					"AlbumID" => utf8_encode($track->getAlbumID()),
					"Recommended" => utf8_encode($track->getRecommended()),
					"FCC" => utf8_encode($track->getFCC()),
					"PrimaryGenre" => utf8_encode($track->getPrimaryGenreID()),
					"SecondaryGenre" => utf8_encode($track->getSecondaryGenreID()) );
			$ret [] = $trackRow;
		}
		return $ret;
	}

	public function getTracksByAlbum($AlbumID){
		$trackArray = $this->manager->GetTracksByAlbum($AlbumID);
		$ret = array ();
		foreach ($trackArray as $track) {
			$trackRow = array (
					"ID" => utf8_encode($track->getID()),
					"Name" => utf8_encode($track->getName()),
					"Artist" => utf8_encode($track->getArtist()),
					"Recommended" => utf8_encode($track->getRecommended()),
					"FCC" => utf8_encode($track->getFCC()),
					"PrimaryGenre" => utf8_encode($track->getPrimaryGenreID()),
					"SecondaryGenre" => utf8_encode($track->getSecondaryGenreID()) );
			$ret [] = $trackRow;
		}
		return $ret;
	}
	
	// Returns a two layered array of albums.
	// It's an array of arrays, with the sub-arrays being a two-item associative array including "ID" and "Name"
	public function getAlbumsByArtist($ArtistID){
		$albumArray = $this->manager->GetAlbumsByID($ArtistID);
		$ret = array();
		foreach ($albumArray as $album) {
			$albumRow = array (
					"ID" => utf8_encode($album->getID()),
					"Name" => utf8_encode($album->getName()) );
			$ret [] = $albumRow;
		}
		return $ret;
	}

	public function getArtists(){
		$artistArray = $this->manager->GetAllArtists(true);
		$allArtist = array();
		foreach ($artistArray as $artist) {
			$artistRow = array (
					"ID" => utf8_encode($artist->getID()),
					"Name" => utf8_encode($artist->getName()) );
			$allArtist[] = $artistRow;
		}
		return $allArtist;
	}
	public function getAlbums(){
		$albumArray = $this->manager->GetAllAlbums(false);
		$allAlbum = array();
		foreach ($albumArray as $album) {
			$albumRow = array (
					"ID" => utf8_encode($album->getID()),
					"Name" => utf8_encode($album->getName()),
					"PrimaryGenre" => utf8_encode($album->getPrimaryGenre()),
					"SecondaryGenre" => utf8_encode($album->getSecondaryGenre()) );
			$allAlbum[] = $albumRow;
		}
		return $allAlbum;
	}
	//Method to retrieve all possible data from the db on this exact track
	public function getTrackData($TrackID)
	{	
		$track = $this->manager->GetAllTrackData($TrackID);
		$arr = array(
			"TrackID"=> utf8_encode($track->getID()),
			"TrackName"=> utf8_encode($track->getName()),
			"AlbumID"=> utf8_encode($track->Album->getID()),
			"AlbumName" => utf8_encode($track->Album->getName()),
			"ArtistID" => utf8_encode($track->Artist->getID()),
			"ArtistName" => utf8_encode($track->Artist->getName()),
			"PlayCount" => utf8_encode($track->getPlayCount()),
			"Genre" => utf8_encode($track->getGenre()),
			"CreateDate" => utf8_encode($track->getCreateDate()),
			"EndDate" => utf8_encode($track->getEndDate()),
			"ReleaseDate" => utf8_encode($track->getReleaseDate()),
		
		);
		return $arr;
	}
	
	public function getInitialInfo(){
		return array("Artists" => $this->getArtists(),
					 "Albums" => $this->getAlbums(),
					 "Genres" => $this->getAllGenres());
	}
	public function getTrackChunk($lastTrack = ""){
		$trackArray = $this->manager->GetTrackChunksAlphabetical($lastTrack);
		$allTracks = array();
		foreach ($trackArray as $track) {
			$trackRow = array(
				"ID" => utf8_encode($track->getID()),
				"Name" => utf8_encode($track->getName()),
				"Artist" => utf8_encode($track->getArtist()),
				"Album" => utf8_encode($track->getAlbum()),
				"AlbumID" => utf8_encode($track->getAlbumID()),
				"Recommended" => utf8_encode($track->getRecommended()),
				"FCC" => utf8_encode($track->getFCC()),
				"PrimaryGenre" => utf8_encode($track->getPrimaryGenreID()),
				"SecondaryGenre" => utf8_encode($track->getSecondaryGenreID()) );
			$allTracks[] = $trackRow;
		}
		return $allTracks;
	}
	public function getAllGenres(){
		$genreArray = $this->manager->GetAllGenres();
		$allGenres = array();
		foreach ($genreArray as $genre) {
			$genreRow = array(
				"ID" => utf8_encode($genre->getID()),
				"Name" => utf8_encode($genre->getName()) );
			$allGenres[] = $genreRow;
		}
		return $allGenres;
	}
}
?>