<?php
	class Album implements JsonSerializable
	{
		private $name;
		private $ID;
		private $TrackList;
		private $PrimaryGenre;
		private $SecondaryGenre;
		
		//Serialize method to create JSON objects
		public function jsonSerialize()
		{
			$arr = array();
			$arr[] = $this->name;
			$arr[] = $this->ID;
			$arr[] = $this->TrackList;
			$arr[] = $this->PrimaryGenre;
			$arr[] = $this->SecondaryGenre;
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
			return $this->PrimaryGenre = $genre;
		}
		
		public function setSecondaryGenre($genre)
		{
			return $this->SecondaryGenre = $genre;
		}
	}
?>