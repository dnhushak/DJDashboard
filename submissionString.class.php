<?php

class submissionString {
	private $string;

	function normalize($the){
		// Normalizes a string:
		
		// Empty String
		if ($this->string == "") {
			return $this->string;
		} 		// String is a space
		elseif ($this->string == " ") {
			$this->string = "";
			return $this->string;
		} else {
			$this->string = explode(" ", $this->string);
			
			// Remove leading and trailing spaces
			while ($this->string [0] == '' || $this->string [0] == ' ' || $this->string [(count($this->string) - 1)] == '' || $this->string [(count($this->string) - 1)] == ' ') {
				if ($this->string [0] == '' || $this->string [0] == ' ') {
					array_shift($this->string);
				}
				if ($this->string [(count($this->string) - 1)] == '' || $this->string [(count($this->string) - 1)] == ' ')
					array_pop($this->string);
			}
			if ($the == 1) {
				switch ($this->string [0]){
					case "the":
						array_shift($this->string);
						break;
					case "The":
						array_shift($this->string);
						break;
				}
			}
			$this->string = implode(" ", $this->string);
			$replacees = array ("'","&",",","\'",".","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�" 
			);
			$replacers = array ("","and","","","","a","a","e","e","i","i","o","o","u","u","a","e","i","o","u","y","a","e","i","o","u","y","a","e","i","o","u","y","a","e","i","o","u","a","e","i","o","u","a","n","o","a","n","o","a","e","i","o","u","y","a","e","i","o","u","y" 
			);
			$this->string = str_replace($replacees, $replacers, $this->string);
			$this->string = stripslashes($this->string);
			$this->string = strtoupper($this->string);
			return $this->string;
		}
	}
}

?>