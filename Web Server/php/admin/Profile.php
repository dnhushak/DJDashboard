<?php
/*
 * Created on Apr 1, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 /**
  * Complete class that will allow us to handle user profiles
  */
 class Profile implements JsonSerializable
 {
 	private $profileID;
 	private $userID;
 	private $nickname;
 	private $bio;
 	private $motto;
 	private $image;
 	private $isOnAir;
 	
 	
 	//Serialize method to create JSON objects
	public function jsonSerialize()
	{
		$arr = array();
		$arr['ProfileID'] = $this->profileID;
		$arr['UserID'] = $this->userID;
		$arr['NickName'] = $this->nickname;
		$arr['Bio'] = $this->bio;
		$arr['Motto'] = $this->motto;
		$arr['Image'] = $this->image;
		$arr['IsOnAir'] = $this->isOnAir;
		return $arr;		
	}
 	
 	public function setOnAir($oa)
 	{
 		$this->isOnAir = $oa;
 		
 	}
 	
 	public function getMotto()
 	{
 		return $this->motto;
 	}
 	
 	public function setMotto($motto)
 	{
 		$this->motto = $motto;
 	}
 	
 	public function setBio($bio)
 	{
 		$this->bio = $bio;
 	}
 	
 	public function getBio()
 	{
 		return $this->bio;
 	}
 	
 	public function setNickname($nn)
 	{
 		$this->nickname = $nn;
 	}
 	
 	public function getNickname()
 	{
 		return $this->nickname;
 	}
 	
 	public function setUserID($id)
 	{
 		$this->userID = $id;
 	}
 	
 	public function getUserID()
 	{
 		return $this->userID;
 	}
 	
 	public function setProfileID($id)
 	{
 		$this->profileID = $id;
 	}
 	
 	public function getProfileID()
 	{
 		return $this->profileID;
 	}
 }
 
?>
