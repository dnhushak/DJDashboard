<?php

/**
 * Normalizes a string by:
 * -Removing unicode characters
 * -Removing extra spaces
 * -Removing leading articles (The, La, etc.)
 * -Conforming to English case rules for proper nouns
 * @param string $string 
 *		The string to normalize
 * @return string
 */
function normalizeAll($string){
	// Empty String or single space, nothing to normalize
	if (string == "" || $string == " ") {
		return "";
	}
	else {
		// Run all separate normalization functions
		$string = normalizeChars();
		$string = removeSpaces();
		$string = removeLeadingArticles();
		$string = normalizeCase();
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
	$strarray = explode(" ", $string);
	// Remove leading spaces
	while ($strarray [0] == '' || $strarray [0] == ' ') {
		array_shift($strarray);
	}
	// Remove trailing spaces
	while ($strarray [(count($strarray) - 1)] == '' || $strarray [(count($strarray) - 1)] == ' ') {
		array_pop($strarray);
	}
	// Reassemble String
	$string = implode(" ", $strarray);
	return $string;
}

/**
 * Normalizes unicode characters, punctuation, and symbols
 *
 * Example:
 *
 * Bjšrk -> Bjork
 *
 * @param string $string
 *        	The string to normalize
 * @return The normalized string
 */
function normalizeChars($string){
	// The array of offending characters
	$replacees = array ("'","&",",","\'",".","À","à","È","è","Ì","ì","Ò","ò","Ù","ù","Á","É","Í","Ó","Ú","Ý","á","é","í","ó","ú","ý","á","é","í","ó","ú","ý","Â","Ê","Î","Ô","Û","â","ê","î","ô","û","Ã","Ñ","Õ","ã","ñ","õ","Ä","Ë","Ï","Ö","Ü","Ÿ","ä","ë","ï","ö","ü","ÿ" );
	// The array of characters to replace the offenders
	$replacers = array ("","and","","","","a","a","e","e","i","i","o","o","u","u","a","e","i","o","u","y","a","e","i","o","u","y","a","e","i","o","u","y","a","e","i","o","u","a","e","i","o","u","a","n","o","a","n","o","a","e","i","o","u","y","a","e","i","o","u","y" );
	// Replace
	$string = str_replace($replacees, $replacers, $string);
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
	$strarray = explode(" ", $string);
	// Iterate over every element of the new array
	foreach ($strarray as $value) {
		// Convert all characters to lowercase
		$value = strtolower($value);
		// Convert first character to uppercase
		$value = ucfirst($value);
	}
	// Reassemble String
	$string = implode(" ", $strarray);
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
	$strarray = explode(" ", $string);
	// List of articles to remove
	$articles = array ("the","la","los","las","le","les" );
	// Check if the first word is an article
	if (in_array($strarray [0], $articles)) {
		$array_shift($strarray);
	}
	// Reassemble string
	$string = implode(" ", $strarray);
	return $string;
}
?>