<?php
/*
 * Created on Mar 3, 2014
 *
 * Created by Robert Clabough
 */
 
 /**
  * Container for grant info for PHP
  */
 class Grant
 {
 	private $grantID;
 	private $name;
 	private $message;
 	
 	public function setGrantID($ID)
 	{
 		$this->grantID = $ID;
 	}
 	public function getGrantID()
 	{
 		return $this->grantID;
 	}
 	public function setGrantName($name)
 	{
 		$this->name = $name;
 	}
 	public function getGrantName()
 	{
 		return $this->name;
 	}
 	public function setMessage($message)
 	{
 		$this->message = $message;
 	}
 	public function getMessage()
 	{
 		return $this->message;
 	}
 }
 
?>
