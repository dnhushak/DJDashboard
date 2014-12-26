<?php
/*
 * Created on Mar 24, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 /**
  * Play types, very simple class to tell UI what type each is
  */
class PlayType
{
	public function __construct($id, $name) {
		$this->TypeName = $name;
		$this->TypeID = $id;
	}
	public $TypeName;
	public $TypeID;
	
	
	
}
 
?>
