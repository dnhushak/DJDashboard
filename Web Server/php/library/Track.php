<?php

class Track {
	private $ID;
	private $Name;
	private $FCC;
	private $Recommended;
	private $PlayCount;	
	private $PrimaryGenreID;
	private $SecondaryGenreID;
	public $Artist;
	private $AlbumID;
	public $Album;
	private $CreateDate;
	private $EndDate;
	private $ReleaseDate;
	
	public function setCreateDate($date)
	{
		$this->CreateDate = $date;
	}
	
	public function setEndDate($date)
	{
		$this->EndDate = $date;
	}
	
	public function setReleaseDate($date)
	{
		$this->ReleaseDate = $date;
	}
	
	public function getCreateDate()
	{
		return $this->CreateDate;
	}
	
	public function getEndDate()
	{
		return $this->EndDate;
	}
	
	public function getReleaseDate()
	{
		return $this->ReleaseDate;
	}
	
	
	// Data Fetching
	public function getPlays(){
	}
	// 'Plays' the track, adds to the plays table
	public function Play(){
		$lib = new LibraryManager();
		$lib->PlayTrack($this->ID);
	}
	// Getters / Setters
	public function getID(){
		return $this->ID;
	}

	public function setID($ID){
		$this->ID = $ID;
	}

	public function getName(){
		return $this->Name;
	}

	public function setName($Name){
		$this->Name = $Name;
	}

	public function getAlbum(){
		return $this->Album;
	}

	
	public function setAlbum($Album){
		$this->Album = $Album;
	}
	
	public function getAlbumID(){
		return $this->AlbumID;
	}

	public function setAlbumID($AlbumID){
		$this->AlbumID = $AlbumID;
	}
	
	public function getArtist(){
		return $this->Artist;
	}
	
	public function setArtist($Artist){
		$this->Artist = $Artist;
	}
	
	public function getFCC(){
		return $this->FCC;
	}

	public function setFCC($FCC){
		$this->FCC = $FCC;
	}

	public function getRecommended(){
		return $this->Recommended;
	}

	public function setRecommended($Reco){
		$this->Recommended = $Reco;
	}

	public function getPrimaryGenreID(){
		return $this->PrimaryGenreID;
	}

	public function setPrimaryGenreID($Genre){
		$this->PrimaryGenreID = $Genre;
	}
	
	
	public function getGenre()
	{
		return getPrimaryGenreID();
	}
	
	public function setGenre($Genre)
	{
		setPrimaryGenreID($Genre);
	}
	
	public function getSecondaryGenreID(){
		return $this->SecondaryGenreID;
	}

	public function setSecondaryGenreID($Genre){
		$this->SecondaryGenreID = $Genre;
	}

	public function setPlayCount()
	{
		return $this->PlayCount;
	}
	
	public function getPlayCount(){
		return $this->PlayCount;
	}
}
?>