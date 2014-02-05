<?php
	include 'sqlconnect.php';
	include 'Artist.php';
	include 'Album.php';
	class LibraryManager
	{
		private $GetArtistsAlphabetical;
		private $GetArtists;
		private $GetAlbumsByArtistID;
		
		
		public function __construct()
		{
			$this->initialize();
		}	

		/**
		 * Build constant procedure names
		 */
		private function initialize()
		{
			$this->GetArtistsAlphabetical = "GetArtistListAlphabetical";
			$this->GetArtists = "GetArtistList";
			$this->GetAlbumsByArtistID = "GetAlbumsFromArtistID";
		}
		
		public function GetAlbumsByID($ArtistID)
		{
			$conn = new SqlConnect();
			$results = $conn->callStoredProc($this->GetAlbumsByArtistID, array($ArtistID));
			$albumList = array();
			while($rowInfo = mysqli_fetch_assoc($results))
			{
				$tempAlbum = new Album();
				$tempAlbum->setName($rowInfo['Album']);
				$tempAlbum->setID($rowInfo['ID']);
				$albumList[] = $tempAlbum;
			}
			return $albumList;
		}
		
		public function GetAllArtists($Alphabetical)
		{
			$conn = new SqlConnect();
			if($Alphabetical)
			{
				$results = $conn->callStoredProc($this->GetArtistsAlphabetical, null);
			}
			else
			{
				$results = $conn->callStoredProc($this->GetArtists, null);
			}
			
			$artistList = array();
			while($rowInfo = mysqli_fetch_assoc($results))
			{
				$tempArtist=new Artist();
	 			$tempArtist->setName($rowInfo['Artist']);
	 			$tempArtist->setID($rowInfo['ID']);
				$artistList[] = $tempArtist;
			}
			
			return $artistList;
			
		}
		
	}
?>