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
			$arr[] = $this->Name;
			$arr[] = $this->ID;
			$arr[] = $this->strTrackList;
			return $arr;
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