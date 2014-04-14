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
 	
 }
?>
