<?php
	class Album
	{
		private $name;
		private $ID;
		private $TrackList;
		
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
	}
?>