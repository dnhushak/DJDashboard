<?php
	class Genre implements JsonSerializable
	{
		private $name;
		private $ID;
		
		public function jsonSerialize()
		{
			$arr = array();
			$arr['GenreName'] = $this->ID;
			$arr['GenreID'] = $this->name;
			return $arr;
		}
		
		public function getName()
		{
			return $this->name;
		}
		
		public function getID()
		{
			return $this->ID;
		}
		
		public function setID($ID)
		{
			$this->ID = $ID;
		}
		
		public function setName($name)
		{
			$this->name = $name;
		}
	}
?>