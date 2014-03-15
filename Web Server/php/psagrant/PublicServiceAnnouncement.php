<?php
/*
 * Created on Mar 15, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 class PublicServiceAnnouncement  implements JsonSerializable
 {
 	private $createDate;
 	private $id;
 	private $name;
 	private $message;
 	private $endDate;
 	private $playCount;
 	
 	/**
 	 *  Creates an array that can be seraialized into a JSON object
 	 */
 	public function jsonSerialize()
	{
		$arr = array();
		$arr['CreateDate'] = $this->createDate;
		$arr['ID'] = $this->id;
		$arr['Name'] = $this->name;
		$arr['Message'] = $this->message;
		$arr['EndDate'] = $this->endDate;
		$arr['PlayCount'] = $this->playCount;
	}
 	
 	public function setCreateDate($date)
 	{
 		$this->createDate = $date;
 	}
 	
 	public function getCreateDate()
 	{
 		return $this->createDate;
 	}
 	
 	public function setID($id)
 	{
 		$this->id = $id;
 	}
 	
 	public function getID()
 	{
 		return $this->id;
 	}
 	
 	public function setName($name)
 	{
 		$this->name = $name;
 	}
 	
 	public function getName()
 	{
 		return $this->name;
 	}
 	
 	public function setMessage($m)
 	{
 		$this->message = $m;
 	}
 	
 	public function getMessage()
 	{
 		return $this->message;
 	}
 	
 	public function setEndDate($endDate)
 	{
 		$this->endDate = $endDate;
 	}
 	
 	public function getEndDate()
 	{
 		return $this->endDate;
 	}
 	
 	public function setPlayCount($pc)
 	{
 		$this->playCount = $pc;
 	}
 	
 	public function getPlayCount()
 	{
 		return $this->playCount;
 	}
 	
 }
?>
