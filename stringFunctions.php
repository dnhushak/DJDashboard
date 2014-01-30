<?php

/**
 * Normalizes a string by:
 * -Removing unicode characters
 * -Removing extra spaces
 * -Removing leading articles (The, La, etc.)
 * -Conforming to English case rules for proper nouns
 *
 * @param string $string
 *        	The string to normalize
 * @return string
 */
function normalizeAll($string){
	// Empty String or single space, nothing to normalize
	if (string == "" || $string == " ") {
		return "";
	}
	else {
		// Run all separate normalization functions
		$string = normalizeChars($string);
		$string = removeLeadingArticles($string);
		$string = normalizeCase($string);
		$string = removeSpaces($string);
		return $string;
	}
}

/**
 * Removes any leading, trailing, or extra spaces in a string, as well as removes newlines, carriage returns, and tabs
 *
 * Example:
 *
 * " The Beatles " -> "The Beatles" (Quotes used to show spaces)
 *
 * @param string $string
 *        	The string to remove spaces from
 * @return The new string without leading or trailing spaces
 */
function removeSpaces($string){
	$string = preg_replace("/\s+/", " ", $string);
	// Split the string into an array of values
	$string = explode(" ", $string);
	// Remove leading spaces
	$string = array_filter($string);
	// Reassemble String
	$string = implode(" ", $string);
	return $string;
}

/**
 * Normalizes unicode characters, punctuation, and symbols
 *
 * Example:
 *
 * Björk -> Bjork
 *
 * @param string $string
 *        	The string to normalize
 * @return The normalized string
 */
function normalizeChars($string){
	
	//Change ampersands to and
	$string = str_replace("&","and", $string);
	//return trim($string);
	// The array of offending characters
	$replacees = array ("'","&",",","\'",".","¿","‡","»","Ë","Ã","Ï","“","Ú","Ÿ","˘","¡","…","Õ","”","⁄","›","·","È","Ì","Û","˙","˝","·","È","Ì","Û","˙","˝","¬"," ","Œ","‘","€","‚","Í","Ó","Ù","˚","√","—","’","„","Ò","ı","ƒ","À","œ","÷","‹","ü","‰","Î","Ô","ˆ","¸","ˇ" );
	// The array of characters to replace the offenders
	$replacers = array ("","and","","","","a","a","e","e","i","i","o","o","u","u","a","e","i","o","u","y","a","e","i","o","u","y","a","e","i","o","u","y","a","e","i","o","u","a","e","i","o","u","a","n","o","a","n","o","a","e","i","o","u","y","a","e","i","o","u","y" );
	// Replace
	$string = str_replace($replacees, $replacers, $string);
	
	//$string = preg_replace('~&([a-z]{1,2})(acute|cedil|circ|grave|lig|orn|ring|slash|th|tilde|uml);~i', '$1', $string);
	//$string = preg_replace(array('~[^0-9a-z]~i', '~-+~'), ' ', $string);
	
	// Remove escape characters
	$string = stripslashes($string);
	return $string;
}

/**
 * Standardizes all cases to normal english capitalization rules for proper nouns
 *
 * Example:
 *
 * bJoRk -> Bjork
 *
 * @param string $string
 *        	The string to normalize
 * @return The normalized string
 */
function normalizeCase($string){
	// Split the string into an array of values
	$string = explode(" ", $string);
	$stringarray [0] = "";
	// Iterate over every element of the new array
	foreach ($string as $value) {
		// Convert all characters to lowercase
		$value = strtolower($value);
		// Convert first character to uppercase
		array_Push($stringarray, ucfirst($value));
	}
	// Reassemble String
	$string = implode(" ", $stringarray);
	return $string;
}

/**
 * Removes articles as the first word of strings
 *
 * Example:
 *
 * The Beatles -> Beatles
 *
 * @param string $string
 *        	The string to normalize
 * @return The normalized string
 */
function removeLeadingArticles($string){
	// Split the string into an array of values
	$string = explode(" ", $string);
	// List of articles to remove
	$articles = array ("the","la","los","las","le","les" );
	// Check if the first word is an article
	while (in_array(strtolower($string [0]), $articles)) {
		array_shift($string);
	}
	// Reassemble string
	$string = implode(" ", $string);
	return $string;
}
?>