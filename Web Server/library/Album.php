<?php
	class Album
	{
		private $name;
		private $ID;
		
		public function getName()
		{
			return $this->name;
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