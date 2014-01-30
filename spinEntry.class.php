<?php

final class spinEntry {
	private $artist;
	private $album;
	private $track;

	public function __construct(){
	}

	public function __destruct(){
	}

	/**
	 * Sets the name of the artist
	 *
	 * @param $artist The
	 *        	string of the artist name
	 */
	public function setArtist($artist){
		if (!empty($artist))
			$this->artist = $artist;
	}

	public function setAlbum($album){
		if (!empty($album))
			$this->album = $album;
	}

	public function settrack($track){
		if (!empty($track))
			$this->track = $album;
	}

	public function normalize(){
		$this->artist = normalizeAll($this->artist);
		$this->album = normalizeAll($this->album);
		$this->track = normalizeAll($this->track);
	}
}
?>