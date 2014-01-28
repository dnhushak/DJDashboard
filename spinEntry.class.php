<?php

final class spinEntry {
	private $artist;
	private $album;
	private $track;

	public function __construct(){
		$this->artist = new submissionString();
		$this->album = new submissionString();
		$this->track = new submissionString();
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
			$this->track = $track;
	}

	public function submit(){
	}
}

?>