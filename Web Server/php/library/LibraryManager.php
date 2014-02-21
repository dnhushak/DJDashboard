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
		private $GetTrackChunksAlphabetical;
		private $spGetTrackData;
		
		
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
			$this->GetTrackChunksAlphabetical = "GetTrackChunksAlphabetical";
			$this->spGetTrackData = "GetAllTrackData";
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
				$tempTrack->setAlbumID($rowInfo['AlbumID']);
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

		/**
		*	Gets the full list of albums.
		**/
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
		
		/**
		*	GetTrackChunksAlphabetical
		*	Used to get a chunked version of the tracks.  Starts with a specified last track.
		*	Does use significant bandwidth.
		**/
		public function GetTrackChunksAlphabetical($lastTrack = ""){
			$conn = new SqlConnect();
			$results = $conn->callStoredProc($this->GetTrackChunksAlphabetical, $lastTrack);
			$trackList = array();
			while($rowInfo = mysqli_fetch_assoc($results)){
				$tempTrack = new Track();
				$tempTrack->setAlbum($rowInfo['AlbumName']);
				$tempTrack->setArtist($rowInfo['ArtistName']);
				$tempTrack->setName($rowInfo['TrackName']);
				$tempTrack->setFCC(($rowInfo['FCC']));
				$tempTrack->setID($rowInfo['TrackID']);
				$tempTrack->setRecommended($rowInfo['Recommended']);
				$tempTrack->setAlbumID($rowInfo['AlbumID']);
				$trackList[] = $tempTrack;
			}
			return $trackList;
		}
		//Returns an array of rows from the db of all the track data
		public function GetAllTrackData($TrackID)
		{
			$conn = new SqlConnect();
			$results = $conn->callStoredProc($this->spGetTrackData, array($TrackID));
			//Keys are 1-1, so there should only be one row
			$r = mysqli_fetch_assoc($results);
			$track = new Track();
			$track->Artist = new Artist();
			$track->Album = new Album();
			$track->Artist->setID($r['idartist']);
			$track->Artist->setName($r['ArtistName']);
			$track->Album->setID($r['idalbum']);
			$track->Album->setName($r['AlbumName']);
			$track->setID($r['idtrack']);
			$track->setName($r['TrackName']);
			$track->setFCC($r['FCC']);
			$track->setRecommended($r['Recommended']);
			$track->setGenre($r['PrimaryGenre']);
			$track->setPlayCount($r['PlayCount']);
			$track->setCreateDate($r['CreateDate']);
			$track->setReleaseDate($r['ReleaseDate']);
			$track->setEndDate($r['EndDate']);
			return $track;
		}
		
		/**
		*	PlayTrack
		*	Will probably be called when a playlist is submitted.
		*	Logs a play of a track, then saves it in the DB.
		*/
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