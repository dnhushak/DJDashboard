<?php
	class Genre
	{
		private $name;
		private $ID;
		
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