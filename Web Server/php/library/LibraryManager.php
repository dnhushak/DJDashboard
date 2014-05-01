<?php
include_once '../sqlconnect.php';
include_once 'Artist.php';
include_once 'Album.php';
include_once 'Track.php';
include_once 'Genre.php';
include_once '../publisher.php';

class LibraryManager {
	private $GetArtistsAlphabetical;
	private $GetArtists;
	private $GetAlbumsByArtistID;
	private $spPlayTrackByID;
	private $spUpdatePlayByID;
	private $GetTracksByAlbumID;
	private $GetAlbums;
	private $GetTrackChunksAlphabetical;
	private $GetTrackChunks;
	private $spGetTrackData;
	private $GetAllGenres;
	private $GetAllTracksByGenreAndReco;
	private $GetAlbumsByGenreAndReco;
	private $GetArtistsByGenreAndReco;
	private $spGetTracksLike;
	private $spGetArtistsWhereTrackLike;
	private $spGetAlbumsWhereTrackLike;
	private $spGetArtistsAutoComplete;
	private $spGetAlbumsAutoComplete;
	private $spGetRecentlyPlayed;
	private $spGetMostPopular;
	private $spGetSubsonicID;
	private $spGetPlaysByTimeSpanAndUserID;
	private $spGetAlbumPlaysByTimeSpanAndUserID;

	public function __construct() {
		$this->initialize();
	}

	/**
	 * Build constant procedure names
	 */
	private function initialize() {
		// Register failure procedure
		register_shutdown_function("Publisher::fatalHandler");

		$this->GetArtistsAlphabetical = "GetArtistListAlphabetical";
		$this->GetArtists = "GetArtistList";
		$this->GetAlbumsByArtistID = "GetAlbumsFromArtistID";
		$this->spPlayTrackByID = "PlayTrackByID";
		$this->spUpdatePlayByID = "UpdatePlayByID";
		$this->GetTracksByAlbumID = "GetTracksByAlbumID";
		$this->GetTracksByArtistID = "GetTracksByArtistID";
		$this->GetAlbums = "GetAlbumList";
		$this->GetTrackChunksAlphabetical = "GetTrackChunksAlphabetical";
		$this->GetTrackChunks = "GetTrackChunks";
		$this->spGetTrackData = "GetAllTrackData";
		$this->GetAllGenres = "GetAllGenre";
		$this->GetAllTracksByGenreAndReco = "GetAllTracksByGenreAndReco";
		$this->GetAlbumsByGenreAndReco = "GetAlbumsByGenreAndReco";
		$this->GetArtistsByGenreAndReco = "GetArtistsByGenreAndReco";
		$this->spGetTracksLike = "GetTracksLike";
		$this->spGetArtistsWhereTrackLike = "GetArtistsWhereTrackLike";
		$this->spGetAlbumsWhereTrackLike = "GetAlbumsWhereTrackLike";
		$this->spGetArtistsAutoComplete = "GetArtistsAutoComplete";
		$this->spGetAlbumsAutoComplete = "GetAlbumsAutoComplete";
		$this->spGetRecentlyPlayed = "GetLast25Played";
		$this->spGetMostPopular = "GetMost25PopularTracks";
		$this->spGetSubsonicID = "GetTrackSubsonicID";
		$this->spGetPlaysByTimeSpanAndUserID = "GetPlaysByTimeSpanAndUserID";
		$this->spGetAlbumPlaysByTimeSpanAndUserID = "GetAlbumPlaysByTimeSpanAndUserID";
	}

	/**
	 * Gets an array of Tracks from the AlbumID
	 */
	public function GetTracksByAlbum($AlbumID) {
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->GetTracksByAlbumID, array (
			$AlbumID
		));
		$trackList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$tempTrack = new Track();
			$tempTrack->setName($rowInfo['Track']);
			$tempTrack->setID($rowInfo['ID']);
			$tempTrack->setFCC($rowInfo['FCC']);
			$tempTrack->setRecommended($rowInfo['Recommended']);
			$tempTrack->setArtist($rowInfo['Artist']);
			$tempTrack->setPrimaryGenreID($rowInfo['idPrimaryGenre']);
			$tempTrack->setSecondaryGenreID($rowInfo['idSecondaryGenre']);
			$tempTrack->setSubsonic(utf8_encode($rowInfo['idsubsonic']));
			$trackList[] = $tempTrack;
		}
		return $trackList;
	}

	public function GetTracksByArtist($ArtistID) {
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->GetTracksByArtistID, array (
			$ArtistID
		));
		$trackList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$tempTrack = new Track();
			$tempTrack->setName($rowInfo['Track']);
			$tempTrack->setAlbum($rowInfo['Album']);
			$tempTrack->setAlbumID($rowInfo['AlbumID']);
			$tempTrack->setArtist($rowInfo['Artist']);
			$tempTrack->setID($rowInfo['ID']);
			$tempTrack->setFCC($rowInfo['FCC']);
			$tempTrack->setRecommended($rowInfo['Recommended']);
			$tempTrack->setPrimaryGenreID($rowInfo['idPrimaryGenre']);
			$tempTrack->setSecondaryGenreID($rowInfo['idSecondaryGenre']);
			$tempTrack->setSubsonic(utf8_encode($rowInfo['idsubsonic']));
			$trackList[] = $tempTrack;
		}
		return $trackList;
	}

	/**
	 * Gets a list of albums by an Artist ID
	 */
	public function GetAlbumsByID($ArtistID) {
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->GetAlbumsByArtistID, array (
			$ArtistID
		));
		$albumList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$tempAlbum = new Album();
			$tempAlbum->setName($rowInfo['Album']);
			$tempAlbum->setID($rowInfo['ID']);
			// This adds the item to the array. Wat?
			$albumList[] = $tempAlbum;
		}
		return $albumList;
	}

	/**
	 * Gets an array of all Artists
	 */
	public function GetAllArtists($Alphabetical) {
		$conn = new SqlConnect();
		if ($Alphabetical) {
			$results = $conn->callStoredProc($this->GetArtistsAlphabetical, null);
		} else {
			$results = $conn->callStoredProc($this->GetArtists, null);
		}

		$artistList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$tempArtist = new Artist();
			$tempArtist->setName($rowInfo['Artist']);
			$tempArtist->setID($rowInfo['ID']);
			$artistList[] = $tempArtist;
		}

		return $artistList;
	}

	/**
	 * Gets the full list of albums.
	 */
	public function GetAllAlbums($Alphbetical) {
		$conn = new SqlConnect();
		if ($Alphbetical) {
			// Need stored procedure for this
		} else {
			$results = $conn->callStoredProc($this->GetAlbums, null);
		}
		$albumList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$tempAlbum = new Album();
			$tempAlbum->setName($rowInfo['Album Name']);
			$tempAlbum->setID($rowInfo['ID']);
			$tempAlbum->setSecondaryGenre($rowInfo['SecondaryGenre']);
			$tempAlbum->setPrimaryGenre($rowInfo['PrimaryGenre']);
			$albumList[] = $tempAlbum;
		}
		return $albumList;
	}

	/**
	 * GetTrackChunksAlphabetical
	 * Used to get a chunked version of the tracks.
	 * Starts with a specified last track.
	 * Does use significant bandwidth.
	 */
	public function GetTrackChunksAlphabetical($lastTrack = "") {
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->GetTrackChunksAlphabetical, $lastTrack);
		$trackList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$tempTrack = new Track();
			$tempTrack->setAlbum($rowInfo['AlbumName']);
			$tempTrack->setArtist($rowInfo['ArtistName']);
			$tempTrack->setName($rowInfo['TrackName']);
			$tempTrack->setFCC(($rowInfo['FCC']));
			$tempTrack->setID($rowInfo['TrackID']);
			$tempTrack->setRecommended($rowInfo['Recommended']);
			$tempTrack->setAlbumID($rowInfo['AlbumID']);
			$tempTrack->setPrimaryGenreID($rowInfo['idPrimaryGenre']);
			$tempTrack->setSecondaryGenreID($rowInfo['idSecondaryGenre']);
			$tempTrack->setSubsonic(utf8_encode($rowInfo['idsubsonic']));
			$trackList[] = $tempTrack;
		}
		return $trackList;
	}
	
	public function GetTrackChunks($lastTrackNum = 0, $chunkSize = 100) {
		$conn = new SqlConnect();
		$args = array();
		$args[] = $lastTrackNum;
		$args[] = $chunkSize;
		$results = $conn->callStoredProc($this->GetTrackChunks, $args);
// 		$trackList = array ();
// 		while ($rowInfo = mysqli_fetch_assoc($results)) {
// 			$tempTrack = new Track();
//  			$tempTrack->setAlbum($rowInfo['AlbumName']);
//  			$tempTrack->setArtist($rowInfo['ArtistName']);
//  			$tempTrack->setName($rowInfo['TrackName']);
//  			$tempTrack->setFCC(($rowInfo['FCC']));
//  			$tempTrack->setID($rowInfo['TrackID']);
// 			$tempTrack->setRecommended($rowInfo['Recommended']);
// 			$tempTrack->setAlbumID($rowInfo['AlbumID']);
// 			$tempTrack->setPrimaryGenreID($rowInfo['idPrimaryGenre']);
// 			$tempTrack->setSecondaryGenreID($rowInfo['idSecondaryGenre']);
// 			$tempTrack->setSubsonic(utf8_encode($rowInfo['idsubsonic']));
// 			$trackList[] = $tempTrack;
// 		}
		$allTracks = array();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$trackRow = array(
					"ID" => utf8_encode($rowInfo['TrackID']),
					"Name" => utf8_encode($rowInfo['TrackName']),
					"Artist" => utf8_encode($rowInfo['ArtistName']),
					"Album" => utf8_encode($rowInfo['AlbumName']),
					"AlbumID" => utf8_encode($rowInfo['AlbumID']),
					"Recommended" => utf8_encode($rowInfo['Recommended']),
					"FCC" => utf8_encode($rowInfo['FCC']),
					"PrimaryGenre" => utf8_encode($rowInfo['idPrimaryGenre']),
					"SecondaryGenre" => utf8_encode($rowInfo['idSecondaryGenre']) );
			$allTracks[] = $trackRow;
		}
// 		var_dump($allTracks);
		return $allTracks;
	}
	// Returns an array of rows from the db of all the track data
	public function GetAllTrackData($TrackID) {
		try {
			$conn = new SqlConnect();
			$results = $conn->callStoredProc($this->spGetTrackData, array($TrackID));
			// Keys are 1-1, so there should only be one row
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
			$track->setPlayCount($r['PlayCount']);
			$track->setCreateDate($r['CreateDate']);
			$track->setReleaseDate($r['ReleaseDate']);
			$track->setEndDate($r['EndDate']);
			$track->setPrimaryGenreID($r['PrimaryGenreID']);
			$track->setSecondaryGenreID($r['SecondGenreID']);
			$track->setSubsonic(utf8_encode($r['idsubsonic']));
			return $track;
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}
	}

	public function GetAllGenres() {
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->GetAllGenres, null);
		$genreList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$tempGenre = new Genre();
			$tempGenre->setName($rowInfo['Name']);
			$tempGenre->setID($rowInfo['idGenre']);
			$genreList[] = $tempGenre;
		}
		return $genreList;
	}

	public function GetTracksByGenreAndReco($genreID, $isReco) {
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->GetAllTracksByGenreAndReco, array (
			$genreID,
			$isReco
		));
		$trackList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$tempTrack = new Track();
			$tempTrack->setArtist(utf8_encode($rowInfo['idArtist']));
			$tempTrack->setName(utf8_encode($rowInfo['Name']));
			$tempTrack->setFCC(utf8_encode($rowInfo['FCC']));
			$tempTrack->setID(utf8_encode($rowInfo['idTrack']));
			$tempTrack->setRecommended(utf8_encode($rowInfo['Recommended']));
			$tempTrack->setAlbumID(utf8_encode($rowInfo['idAlbum']));
			$tempTrack->setPrimaryGenreID(utf8_encode($rowInfo['idPrimaryGenre']));
			$tempTrack->setSecondaryGenreID(utf8_encode($rowInfo['idSecondaryGenre']));
			$tempTrack->setSubsonic(utf8_encode($rowInfo['idsubsonic']));
			$trackList[] = $tempTrack;
		}
		return $trackList;
	}

	public function GetArtistsByGenreAndReco($genreID, $isReco) {
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->GetArtistsByGenreAndReco, array (
			$genreID,
			$isReco
		));
		$artistList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$artistList[] = $rowInfo['idartist'];
		}
		return $artistList;
	}

	public function GetAlbumsByGenreAndReco($genreID, $isReco) {
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->GetAlbumsByGenreAndReco, array (
			$genreID,
			$isReco
		));
		$albumList = array ();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$albumList[] = $rowInfo['idalbum'];
		}
		return $albumList;
	}

	/**
	 * PLAY TRACKS
	 * Two types of functions here, one is static, the other instance.
	 * This will allow very easy playing of tracks.
	 * When the track is played, it is logged in the DB with the following values:
	 * trackID - Track ID of the track being played (foreign key to track)
	 * userID - User who is playing this track
	 * onairsession - On air session ID of this track (can be linked to playlists later)
	 */
	public function PlayTrack($UserID, $TrackID, $OnAirSessionID) {
		try {
			$conn = new sqlConnect();
			$results = $conn->callStoredProc($this->spPlayTrackByID, array (
				$TrackID,
				$UserID,
				$OnAirSessionID
			));
			if (!$results) {
				throw new Exception('Error in sql query; PlayTrack in LibraryManager');
			} else {
				// Track played successfully
				$id = null; // This will be returned up.
				while ($rowInfo = mysqli_fetch_assoc($results)) {
					$id = utf8_encode($rowInfo['PlayID']);
					return $id;
				}
			}
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}
	}

	public function UpdatePlay($PlayID, $TrackID, $UserID) {
		try {
			$conn = new sqlConnect();
			$results = $conn->callStoredProc($this->spUpdatePlayByID, array (
				$PlayID,
				$TrackID,
				$UserID
			));
			if (!$results) {
				throw new Exception('Error in sql query; PlayTrack in LibraryManager');
			} else {
				// Track played successfully
				return true;
			}
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}
	}

	public function GetTrackAutoComplete($track) {
		try {
			$conn = new sqlConnect();
			// Get tracks like likename
			$results = $conn->callStoredProc($this->spGetTracksLike, array (
				$track
			));
			$trackList = array ();
			if ($results == false) {
				throw new exception("TrackResults are null in LibraryManager.GetTracksLike()");
			}
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$tempTrack = new Track();
				$tempTrack->setArtist(utf8_encode($rowInfo['idArtist']));
				$tempTrack->setName(utf8_encode($rowInfo['Name']));
				$tempTrack->setFCC((utf8_encode($rowInfo['FCC'])));
				$tempTrack->setID(utf8_encode($rowInfo['idTrack']));
				$tempTrack->setRecommended(utf8_encode($rowInfo['Recommended']));
				$tempTrack->setAlbum(utf8_encode($rowInfo['idAlbum']));
				$tempTrack->setPrimaryGenreID(utf8_encode($rowInfo['idPrimaryGenre']));
				$tempTrack->setSecondaryGenreID(utf8_encode($rowInfo['idSecondaryGenre']));
				$tempTrack->setSubsonic(utf8_encode($rowInfo['idsubsonic']));
				$trackList[] = $tempTrack;
			}
			return $trackList;
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}
	}

	public function GetAlbumsAutoComplete($album) {
		try {
			$conn = new sqlConnect();
			$results = $conn->callStoredProc($this->spGetAlbumsAutoComplete, array (
				$album
			));
			$albumList = array ();
			if ($results == false) {
				throw new exception("AlbumResults are null in LibraryManager.GetTracksLike()");
			}
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$tempAlbum = new Album();
				$tempAlbum->setID(utf8_encode($rowInfo['idAlbum']));
				$tempAlbum->setName(utf8_encode($rowInfo['Name']));
				$albumList[] = $tempAlbum;
			}
			return $albumList;
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}
	}

	public function GetArtistsAutoComplete($artist) {
		try {
			$conn = new sqlConnect();
			$results = $conn->callStoredProc($this->spGetArtistsAutoComplete, array (
				$artist
			));
			$artistList = array ();
			if ($results == false) {
				throw new exception("AlbumResults are null in LibraryManager.GetArtistsAutoComplete()");
			}
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$tempArtist = new Artist();
				$tempArtist->setID(utf8_encode($rowInfo['idArtist']));
				$tempArtist->setName(utf8_encode($rowInfo['Name']));
				$artistList[] = $tempArtist;
			}
			return $artistList;
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}
	}

	public function GetTracksLike($LikeName) {
		// Build master array
		$completeArray = array ();
		$conn = new sqlConnect();

		try {
			// Get tracks like likename
			$trackList = $this->GetTrackAutoComplete($LikeName);
			$completeArray['Tracks'] = $trackList;

			// Get albums where trackname like likename
			$conn->freeResults();
			$results = $conn->callStoredProc($this->spGetAlbumsWhereTrackLike, array (
				$LikeName
			));
			$albumList = array ();
			if ($results == false) {
				throw new exception("AlbumResults are null in LibraryManager.GetTracksLike()");
			}
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$tempAlbum = new Album();
				$tempAlbum->setID(utf8_encode($rowInfo['idAlbum']));
				$albumList[] = $tempAlbum;
			}
			$completeArray['Albums'] = $albumList;

			// Get Artists where trackname like likename
			$conn->freeResults();
			$results = $conn->callStoredProc($this->spGetArtistsWhereTrackLike, array (
				$LikeName
			));
			$artistList = array ();
			if ($results == false) {
				throw new exception();
			}
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$tempArtist = new Artist();
				$tempArtist->setID(utf8_encode($rowInfo['idArtist']));
				$artistList[] = $tempArtist;
			}
			$completeArray['Artists'] = $artistList;

			return $completeArray;
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		} catch (string $str) {
			Publisher :: publishException("Custom Exception", $str, 0);
			return false;
		}
	}
	public function GetRecentlyPlayed() {

		$trackArray = array();
		$conn = new sqlConnect();

		try {
			$results = $conn->callStoredProc($this->spGetRecentlyPlayed, null);
			$trackList = array();
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$tempTrack = new Track();
				$tempTrack->setID(utf8_encode($rowInfo['TrackID']));
				$tempTrack->setName(utf8_encode($rowInfo['TrackName']));
				$tempTrack->setAlbum(utf8_encode($rowInfo['AlbumName']));
				$tempTrack->setArtist(utf8_encode($rowInfo['ArtistName']));
				$trackList[] = $tempTrack;
			}
			return $trackList;

		}catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		} catch (string $str) {
			Publisher :: publishException("Custom Exception", $str, 0);
			return false;
		}
	}
	public function GetMostPopular($startDate){
		$trackArray = array();
		$conn = new sqlConnect();

		try {
			$results = $conn->callStoredProcWithDate($this->spGetMostPopular, array($startDate));
			$trackList = array();
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$tempTrack = new Track();
				$tempTrack->setID(utf8_encode($rowInfo['TrackID']));
				$tempTrack->setName(utf8_encode($rowInfo['TrackName']));
				$tempTrack->setArtist(utf8_encode($rowInfo['ArtistName']));
				$trackList[] = $tempTrack;
			}
			return $trackList;

		}catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		} catch (string $str) {
			Publisher :: publishException("Custom Exception", $str, 0);
			return false;
		}
	}
	public function GetSubsonicID($trackData){
		$conn = new sqlConnect();

		try {
			$results = $conn->callStoredProc($this->spGetSubsonicID, array($trackData));
			return mysqli_fetch_assoc($results);

		}catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		} catch (string $str) {
			Publisher :: publishException("Custom Exception", $str, 0);
			return false;
		}
	}
	public function getPlaysByTimeSpanAndUserID($startDate, $endDate, $userID){

		try{
			$conn = new sqlconnect();
			$results = $conn->callStoredProc($this->spGetPlaysByTimeSpanAndUserID, array($startDate, $endDate, $userID));
			$arr = array();
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$innerArr = array();
				
				$innerArr['TrackName'] = utf8_encode($rowInfo['TrackName']);
				$innerArr['PlayCount'] = utf8_encode($rowInfo['TimeframePlayCount']);
				
				$arr[] = $innerArr;
			}
			return $arr;
		}
		catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), $this->userID);
			return false;
		}
	}
	public function getAlbumPlaysByTimeSpanAndUserID($startDate, $endDate, $userID){

		try{
			$conn = new sqlconnect();
			$results = $conn->callStoredProc($this->spGetAlbumPlaysByTimeSpanAndUserID, array($startDate, $endDate, $userID));
			$arr = array();
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$innerArr = array();
				
				$innerArr['AlbumName'] = utf8_encode($rowInfo['AlbumName']);
				$innerArr['PlayCount'] = utf8_encode($rowInfo['TimeframePlayCount']);
				
				$arr[] = $innerArr;
			}
			return $arr;
		}
		catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), $this->userID);
			return false;
		}
	}
}
?>