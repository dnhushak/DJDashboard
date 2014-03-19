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
 	private $sponsor;
 	private $maxplaycount;
 	private $timeLeft;
 	private $priority;
 	
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
		$arr['MaxPlayCount'] = $this->playCount;
		$arr['Sponsor'] = $this->sponsor;
		$arr['TimeLeft'] = $this->timeLeft;
		$arr['Priority'] = $this->priority;
		return $arr;
	}
	
	//COMPARER
 	static function cmp($a, $b)
	{
    	return $a->priority < $b->priority;
	}
	
	public function setPriority($p)
	{
		$this->priority = $p;
	}
	
	public function setTimeLeft($tl)
	{
		$this->timeLeft = $tl;
	}
	
	public function getTimeLeft()
	{
		return $this->timeLeft;
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
 	
 	public function setSponsor($spon)
 	{
 		$this->sponsor = $spon;
 	}
 	
 	public function getSponsor()
 	{
 		return $this->sponsor;
 	}
 	
 	public function setMaxPlayCount($p)
 	{
 		$this->maxplaycount = $p;
 	}
 	
 	public function getMaxPlayCount()
 	{
 		return $this->maxplaycount;
 	}
 }
?>
