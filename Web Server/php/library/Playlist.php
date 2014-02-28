<?php
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );

class Playlist implements JsonSerializable
{
	private $ID;
	private $Name;
	private $strTrackList;
	private $arrTrackList;
	
	public function jsonSerialize()
	{
			$arr = array();
			$arr['PlaylistName'] = $this->Name;
			$arr['PlaylistID'] = $this->ID;
			$arr['TrackString'] = $this->strTrackList;
			$arr['TrackArray'] = $this->arrTrackList;
			return $arr;
	}
	
	//Set this option to an array of tracks.
	public function setArrTrackList($arr)
	{
		$this->arrTrackList = $arr;
	}
	
	public function getArrTrackList()
	{
		return $this->arrTrackList;
	}
	
	public function setID($aID)
	{
		$this->ID = $aID;
	}
	public function getID()
	{
		return $this->ID;
	}

	public function setName($name)
	{
		$this->Name = $name;
	}
	
	public function getName()
	{
		return $this->Name;
	}
	
}

?>