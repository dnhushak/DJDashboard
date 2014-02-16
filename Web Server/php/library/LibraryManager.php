<?php
	include_once '../sqlconnect.php';
	include_once 'Artist.php';
	include_once 'Album.php';
	include_once 'Track.php';
	class LibraryManager
	{
		private $GetArtistsAlphabetical;
		private $GetArtists;
		private $GetAlbumsByArtistID;
		private $PlayTrackByID;
		private $GetTracksByAlbumID;
		private $GetAlbums;
		
		
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
			$this->GetTracksByArtistID = "GetTracksByArtistID";
			$this->GetAlbums = "GetAlbumList";
		}
		
		/**
		*	Gets an array of Tracks from the AlbumID
		**/
		public function GetTracksByAlbum($AlbumID)
		{
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
				$tempTrack->setArtist($rowInfo['Artist']);
				$trackList[] = $tempTrack;
			}
			return $trackList;
		}
		
		public function GetTracksByArtist($ArtistID){
			$conn = new SqlConnect();
			$results = $conn->callStoredProc($this->GetTracksByArtistID, array($ArtistID));
			$trackList = array();
			while($rowInfo = mysqli_fetch_assoc($results))
			{
				$tempTrack = new Track();
				$tempTrack->setName($rowInfo['Track']);
				$tempTrack->setAlbum($rowInfo['Album']);
				$tempTrack->setArtist($rowInfo['Artist']);
				$tempTrack->setID($rowInfo['ID']);
				$tempTrack->setFCC($rowInfo['FCC']);
				$tempTrack->setRecommended($rowInfo['Recommended']);
				$trackList[] = $tempTrack;
			}
			return $trackList;
		}
		
		/**
		*	Gets a list of albums by an Artist ID
		**/
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
				//This adds the item to the array. Wat?
				$albumList[] = $tempAlbum;
			}
			return $albumList;
		}
		
		/**
		*	Gets an array of all Artists
		**/
		public function GetAllArtists($Alphabetical)
		{
			$conn = new SqlConnect();
			$results;
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

		public function GetAllAlbums($Alphbetical){
			$conn = new SqlConnect();
			$results;
			if($Alphbetical){
				//Need stored procedure for this
			}else{
				$results = $conn->callStoredProc($this->GetAlbums, null);
			}
			$albumList = array();
			while($rowInfo = mysqli_fetch_assoc($results)){
				$tempAlbum = new Album();
				$tempAlbum->setName($rowInfo['Album Name']);
				$tempAlbum->setID($rowInfo['ID']);
				$albumList[] = $tempAlbum;
			}
			return $albumList;
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