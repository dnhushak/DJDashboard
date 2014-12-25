<?php
	class Album implements JsonSerializable
	{
		private $name;
		private $ID;
		private $TrackList;
		private $PrimaryGenre;
		private $SecondaryGenre;
		private $artistID;
		
		//Serialize method to create JSON objects
		public function jsonSerialize()
		{
			$arr = array();
			$arr['AlbumName'] = $this->name;
			$arr['AlbumID'] = $this->ID;
			$arr['TrackList'] = $this->TrackList;
			$arr['PrimaryGenreID'] = $this->PrimaryGenre;
			$arr['SecondaryGenreID'] = $this->SecondaryGenre;
			$arr['ArtistID'] = $this->artistID;
			return $arr;
		}
		
		public function getTracks()
		{
			$lib = new LibraryManager();
			$this->TrackList = $lib->GetTracksByAlbum($this->ID);
			return $this->TrackList;
		}
		
		public function getName()
		{
			return $this->name;
		}
		
		public function getID(){
			return $this->ID;
		}
		
		public function setID($ID)
		{
			$this->ID = $ID;
		}
		
		public function setName($name)
		{
			$this->name = $name;
		}

		public function getPrimaryGenre()
		{
			return $this->PrimaryGenre;
		}

		public function getSecondaryGenre()
		{
			return $this->SecondaryGenre;
		}

		public function setPrimaryGenre($genre)
		{
			$this->PrimaryGenre = $genre;
		}
		
		public function setSecondaryGenre($genre)
		{
			$this->SecondaryGenre = $genre;
		}
		
		public function setArtistID($id){
			$this->artistID = $id;
		}
		
		public function getArtistID(){
			return $this->artistID;
		}
	}
?>