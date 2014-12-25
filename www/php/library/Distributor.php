<?php

class Album implements JsonSerializable {
	private $name;
	private $ID;
	private $phone;
	private $email;
	private $contactName;
	private $location;
	private $affiliated;
	private $website;
	private $digitalDownload;
	private $weight;
	
	// Serialize method to create JSON objects
	public function jsonSerialize(){
		$arr = array ();
		$arr ['AlbumName'] = $this->name;
		$arr ['AlbumID'] = $this->ID;
		$arr ['phone'] = $this->phone;
		$arr ['email'] = $this->email;
		$arr ['contactName'] = $this->contactName;
		$arr ['location'] = $this->location;
		$arr ['affiliated'] = $this->affiliated;
		$arr ['website'] = $this->website;
		$arr ['digitalDownload'] = $this->digitalDownload;
		$arr ['weight'] = $this->weight;
		return $arr;
	}
	
	// Getters
	public function getName(){
		return $this->name;
	}

	public function getID(){
		return $this->ID;
	}

	public function getPhone(){
		return $this->phone;
	}

	public function getEmail(){
		return $this->email;
	}

	public function getContactName(){
		return $this->contactName;
	}

	public function getLocation(){
		return $this->location;
	}

	public function getAffiliated(){
		return $this->affiliated;
	}

	public function getWebsite(){
		return $this->website;
	}

	public function getDigitalDownload(){
		return $this->digitalDownload;
	}

	public function getWeight(){
		return $this->weight;
	}

	public function setID($ID){
		$this->ID = $ID;
	}
	
	// Setters
	public function setName($name){
		$this->name = $name;
	}

	public function getPhone($phone){
		$this->phone = $phone;
	}

	public function getEmail($email){
		$this->email = $email;
	}

	public function getContactName($contactName){
		$this->contactName = $contactName;
	}

	public function getLocation($location){
		$this->location = $location;
	}

	public function getAffiliated($affiliated){
		$this->affiliated = $affiliated;
	}

	public function getWebsite($website){
		$this->website = $website;
	}

	public function getDigitalDownload($digitalDownload){
		$this->digitalDownload = $digitalDownload;
	}

	public function getWeight($weight){
		$this->weight = $weight;
	}
}

?>