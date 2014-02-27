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

	public static function CreatePlaylist($UserID, $TrackArray, $PlaylistName)
	{
		//Create a comma delim'd string
		$idString = "";
		
		foreach ($TrackArray as &$value) 
		{
			$idString = $idString . $value . ",";
		}
		
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
				$tempPlaylist->setID($rowInfo['idplaylist']);
				$tempPlaylist->setName($rowInfo['name']);
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
				$completePlaylist[] = $this->RetrievePlaylistByID($value->getID());
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
				$trk->setID($rowInfo['idtrack']);
				$trk->setName($rowInfo['TrackName']);
				$alb->setID($rowInfo['idalbum']);
				$alb->setName($rowInfo['AlbumName']);
				$art->setID($rowInfo['idartist']);
				$art->setName($rowInfo['ArtistName']);
				
				$trk->setCreateDate($rowInfo['CreateDate']);
				$trk->setReleaseDate($rowInfo['ReleaseDate']);
				$trk->setFCC($rowInfo['FCC']);
				$trk->setRecommended($rowInfo['Recommended']);
				$trk->setPrimaryGenreID($rowInfo['PrimaryGenreID']);
				$trk->setSecondaryGenreID($rowInfo['SecondaryGenreID']);
				$trk->setPlayCount($rowInfo['PlayCount']);
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