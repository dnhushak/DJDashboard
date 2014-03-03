<?php

include_once('../publisher.php');
include_once('LibraryManager.php');
include_once('../sqlconnect.php');

/*
 * Created on Mar 2, 2014
 *
 * Created by Robert Clabough
 * an extension to the class LibraryManager, this class will only add and edit items from the library
 * 
 * "Live long and propser" - Spock
 */
 
 class LibraryEditor
 {
 	private $spInsertCustomTrack;
 	
 	
 	public function __construct()
	{
		$this->initialize();
	}	
 	
 	public function initialize()
 	{
 		$this->spInsertCustomTrack = "InsertCustomTrack";
 	
 	}
 	
 	/**
 	 * Creates a custom track in the database.  It will not be connect to an ITLID or subsonic ID
 	 * It expects to have idArtist and idAlbum already filled. (Either by already existing in the
 	 * database or seperate functions called to add them)  If not, it will throw an error.
 	 */
 	public function insertCustomTrack($track)
 	{
 		$userID = 0; //Must be set later.
 		$stacktrace = "library/LibraryEditor.php:LibraryEditor/insertCustomTrack()";
 		if(($track->Artist == null)||($track->Album == null))
 		{
 			$message = "Artist or Album objects were null!";
 			Publisher::publishUserError($userID, $stacktrace, $message);
 			return false;
 		}
 		
 		//Artist and Albums are set.  We can continue
 		
 		//Build the array of items.
 		$arr = array();
 		$arr[] = $track->getName();
 		$arr[] = $track->Album->getID();
 		$arr[] = $track->Artist->getID();
 		$arr[] = $track->getEndDate();
 		$arr[] = $track->getReleaseDate();
 		$arr[] = $track->getFCC();
 		$arr[] = $track->getRecommended();
 		$arr[] = $track->getPath();
 		$arr[] = $track->getPlayCount();
 		$arr[] = $track->getPrimaryGenreID();
 		$arr[] = $track->getSecondaryGenreID();

 		//Query
 		$conn = new sqlConnect();
 		
 		try
 		{
 			$results = $conn->callStoredProc($this->spInsertCustomTrack, $arr);
 			if($results == false)
 			{
 				throw new Exception("Error in SQL Query");
 			}
 			$rowInfo = mysqli_fetch_assoc($results);
 			$newTrackID = utf8_encode($rowInfo['TrackID']);

			return $newTrackID;
 		}
 		catch (Exception $e)
		{
			Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $userID);
			return false;
		}
 		
 		
 	}
 }
 
?>
