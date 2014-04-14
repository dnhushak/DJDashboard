<?php
/*
 * Created on Apr 1, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 class User implements JsonSerializable
 {
 	private $userID;
 	private $firstName;
 	private $lastName;
 	private $userName;
 	private $userTypeID;
 	private $nickName;
 	private $email;
 	private $isOnAir;
 	private $profile; //IS OF Profile TYPE
 	private $usertypename;
 	private $startDate;
 	private $endDate;
 	private $lastLogOn;
 	private $lastLogOff;
 	private $isActiveUser;
 	
 	public function __construct() {
 		$this->userID = "";
 		$this->firstName = "";
 		$this->lastName = "";
 		$this->userName = "";
 		$this->userTypeID = "";
 		$this->nickName = "";
 		$this->email = "";
 		$this->isonAir = "";
 		$this->profile = "";
 		$this->usertypename = "";
 		$this->startDate = "";
 		$this->endDate = "";
 		$this->lastLogOn = "";
 		$this->lastLogOff = "";
 		$this->isActiveUser = "";
 	}
 	
 	//Serialize method to create JSON objects
	public function jsonSerialize()
	{
		$arr = array();
		$arr['UserID'] = $this->userID;
		$arr['FirstName'] = $this->firstName;
		$arr['LastName'] = $this->lastName;
		$arr['UserName'] = $this->userName;
		$arr['UserTypeID'] = $this->userTypeID;
		$arr['NickName'] = $this->nickName;
		$arr['isOnAir'] = $this->isOnAir;
		$arr['Profile'] = $this->profile;	
		$arr['email'] = $this->email;
		$arr['UserTypeName'] = $this->usertypename;
		$arr['StartDate'] = $this->startDate;
		$arr['EndDate'] = $this->endDate;
		$arr['LastLogOn'] = $this->lastLogOn;
		$arr['LastLogOff'] = $this->lastLogOff;
		$arr['ActiveUser'] = $this->isActiveUser;
		return $arr;
	}
 	
 	public function setProfile($prof)
 	{
 		$this->profile = $prof;
 	}
 	
 	//Very bad function, is used directly from table structure...
 	public static function setFromTable($table)
 	{
 		$u = new User();
 		$u->userID = utf8_encode($table['iduser']);
 		$u->firstName = utf8_encode($table['FirstName']);
 		$u->lastName = utf8_encode($table['LastName']);
 		$u->userName = utf8_encode($table['username']);
 		$u->nickName = utf8_encode($table['nickname']);
 		$u->isOnAir = utf8_encode($table['OnAir']);
 		$u->userTypeID = utf8_encode($table['idusertype']);
 		$u->email = utf8_encode($table['email']);
 		return $u;
 	}
 	
 	public static function setFromAllUser($table){
 		$u = new User();
 		$u->userID = utf8_encode($table['iduser']);
 		$u->firstName = utf8_encode($table['FirstName']);
 		$u->lastName = utf8_encode($table['LastName']);
 		$u->userName = utf8_encode($table['username']);
 		$u->userTypeID = utf8_encode($table['idusertype']);
 		$u->email = utf8_encode($table['email']);
 		$u->usertypename = utf8_encode($table['UserTypeName']);
 		$u->startDate = utf8_encode($table['StartDate']);
 		$u->endDate = utf8_encode($table['EndDate']);
 		$u->lastLogOn = utf8_encode($table['LastLogOn']);
 		$u->lastLogOff = utf8_encode($table['LastLogOff']);
 		$u->isActiveUser = utf8_encode($table['Active']);
 		return $u;
 		
 	}
 	
 }
?>
