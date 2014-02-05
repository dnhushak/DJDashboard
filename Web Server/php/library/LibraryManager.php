<?php
	include '../sqlconnect.php';
	include 'Artist.php';
	include 'Album.php';
	include 'Track.php';
	class LibraryManager
	{
		private $GetArtistsAlphabetical;
		private $GetArtists;
		private $GetAlbumsByArtistID;
		private $PlayTrackByID;
		private $GetTracksByAlbumID;
		
		
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
			$this->PlayTrackByID = "PlayTrackByID";
			$this->GetTracksByAlbumID = "GetTracksByAlbumID";
		}
		
		public function GetTracksByAlbum($AlbumID)
		{
			echo "Album ID : " . $AlbumID . "<br>";
			$conn = new SqlConnect();
			$results = $conn->callStoredProc($this->GetTracksByAlbumID, array($AlbumID));
			$trackList = array();
			while($rowInfo = mysqli_fetch_assoc($results))
			{
				$tempTrack = new Track();
				$tempTrack->setName($rowInfo['Track']);
				$tempTrack->setID($rowInfo['ID']);
				$tempTrack->setFCC($rowInfo['FCC']);
				$tempTrack->setRecommended($rowInfo['Recommended']);
				$trackList[] = $tempTrack;
			}
			return $trackList;
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
		
		public function PlayTrack($ID)
		{
			$conn = new SqlConnect();
			$UserID = 1;
			$OnAirSessionID = null;
			$results = $conn->calledStoredProc($this->PlayTrackByID, array($ID, $UserID, $OnAirSessionID));
			
			//USER INFORMATION
			//LOGIN INFORMATION
		}
	}
?>