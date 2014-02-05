<?php
	class Artist
	{
		private $name;
		private $ID;
		private $AlbumList;
		
		public function getAlbums()
		{
			$lib = new LibraryManager();
			$this->AlbumList = $lib->GetAlbumsByID($this->ID);
			return $this->AlbumList;
		}
		
		public function getName()
		{
			return $this->name;
		}
		
		public function getID()
		{
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