<?php
include_once('LibraryManager.php');
include_once('Playlist.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );

//Playlist Manager
//Used to save or retrieve playlists to/from database.

class PlaylistManager
{
	private static $spInsertPlaylist = "InsertPlaylist";
	private static $spRetrieveUserPlaylistIDs = "RetrieveUserPlaylistIDs";
	private static $spGetPlaylistTracks = "GetPlaylistTracks";

	public function __construct() {
		//print "In BaseClass constructor\n";
	}

	public static function CreatePlaylist($UserID, $idString, $PlaylistName)
	{
		//Create a comma delim'd string
		
		try
		{
			$conn = new sqlConnect();
			$conn->callStoredProc(PlaylistManager::$spInsertPlaylist, array($UserID, $PlaylistName, $idString));
			return true;
		}
		catch (Exception $e)
		{
			Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
			return false;
		}
	}
	
	public function RetrievePlaylistIDsByUserID($UserID)
	{
		try
		{
			$arrPlayList = array();
			$conn = new sqlConnect();
			$results = $conn->callStoredProc(PlaylistManager::$spRetrieveUserPlaylistIDs, array($UserID));
			while($rowInfo = mysqli_fetch_assoc($results)){
				$tempPlaylist = new Playlist();
				$tempPlaylist->setID(utf8_encode($rowInfo['idplaylist']));
				$tempPlaylist->setName(utf8_encode($rowInfo['name']));
				$arrPlayList[] = $tempPlaylist;
			}
			return $arrPlayList;
		}
		catch (Exception $e)
		{
			Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
			return false;
		}
	}
	
	public function RetrieveAllPlaylistsByUserID($UserID)
	{
		try
		{
			$playlistArray = $this->RetrievePlaylistIDsByUserID($UserID);
			$completePlaylist = array();
			foreach($playlistArray as $value)
			{
				
				$value->setArrTrackList($this->RetrievePlaylistByID($value->getID()));
				$completePlaylist[$value->getID()] = $value;
				//$completePlaylist[] = $this->RetrievePlaylistByID($value->getID());
			}
			return $completePlaylist;
		}
		catch (Exception $e)
		{
			Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
			return false;
		}
	}
	
	public function RetrievePlaylistByID($PlaylistID)
	{
		try
		{
			$trackList = array();
			$conn = new sqlConnect();
			$results = $conn->callStoredProc(PlaylistManager::$spGetPlaylistTracks, array($PlaylistID));
			while($rowInfo = mysqli_fetch_assoc($results))
			{
				$trk = new Track();
				$alb = new Album();
				$art = new Artist();
				$trk->setID(utf8_encode($rowInfo['idtrack']));
				$trk->setName(utf8_encode($rowInfo['TrackName']));
				$alb->setID(utf8_encode($rowInfo['idalbum']));
				$alb->setName(utf8_encode($rowInfo['AlbumName']));
				$art->setID(utf8_encode($rowInfo['idartist']));
				$art->setName(utf8_encode($rowInfo['ArtistName']));
				
				$trk->setCreateDate(utf8_encode($rowInfo['CreateDate']));
				$trk->setReleaseDate(utf8_encode($rowInfo['ReleaseDate']));
				$trk->setFCC(utf8_encode($rowInfo['FCC']));
				$trk->setRecommended(utf8_encode($rowInfo['Recommended']));
				$trk->setPrimaryGenreID(utf8_encode($rowInfo['PrimaryGenreID']));
				$trk->setSecondaryGenreID(utf8_encode($rowInfo['SecondaryGenreID']));
				$trk->setPlayCount(utf8_encode($rowInfo['PlayCount']));
				$trk->setAlbum($alb);
				$trk->setArtist($art);
				$trackList[] = $trk;
			}
			return $trackList;
		}
		catch (Exception $e)
		{
			Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
			return false;
		}
	}
	

}	
	
?>