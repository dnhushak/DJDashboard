<?php
/*
 * Created on Mar 24, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 include_once('../sqlconnect.php');
 include_once('PlayTypes.php');
 /**
  * This class handles the viewing of the plays.  Since there are multiple types of things to play,
  * this is the location that will handle the manipulating of them.
  */
 class PlayManager
 {
 	private $spGetEnumeratedTypes;
 	private $spGetPlays;
 	
 	private $conn;
 	private $userID;
 	
 	private $TrackType;
 	private $GrantType;
 	private $PSAType;
 	
 	public function __construct() {
 		try
 		{
 			$this->userID = $_SESSION['userid'];
 			$this->initialize();
 		}
 		catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), $this->userID);
			return false;
		}
		
	}

	/**
	 * Build constant procedure names
	 */
	private function initialize() {
		$this->spGetEnumeratedTypes = "GetPlayableTypes";
		$this->spGetPlays = "GetRecentPlays";
		$this->conn = new sqlconnect();
		$results = $this->conn->callStoredProc($this->spGetEnumeratedTypes, null);
		
		
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$name = utf8_encode($rowInfo['TypeName']);
			switch($name)
			{
				case 'Track':
					$this->TrackType = new PlayType(utf8_encode($rowInfo['TypeID']), $name);
				break;
				case 'Grant':
					$this->GrantType = new PlayType(utf8_encode($rowInfo['TypeID']), $name);
				break;
				case 'PSA':
					$this->PSAType = new PlayType(utf8_encode($rowInfo['TypeID']), $name);
				break;
			}
		}
		$this->conn->freeResults();
	}

	public function getTypes()
	{
		$arr = array();
		$arr[$this->TrackType->TypeName] = $this->TrackType;
		$arr[$this->GrantType->TypeName] = $this->GrantType;
		$arr[$this->PSAType->TypeName] = $this->PSAType;
		return $arr;
	}

	public function getPlays()
	{
		try
		{
		$results = $this->conn->callStoredProc($this->spGetPlays, null);
		$arr = array();
		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$innerArr = array();
			foreach($rowInfo as $str)
			{
				$innerArr[] = utf8_encode($str);
			}
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
