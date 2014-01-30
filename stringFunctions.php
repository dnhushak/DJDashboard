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
	// The array of offending characters
	$replace = array ('&' => 'And','À' => 'A','Á' => 'A','Â' => 'A','Ã' => 'A','Ä' => 'A','Å' => 'A','Æ' => 'AE','Ă' => 'A','à' => 'a','á' => 'a','â' => 'a','ã' => 'a','ä' => 'a','å' => 'a','ă' => 'a','æ' => 'ae','þ' => 'b','Þ' => 'B','Ç' => 'C','ç' => 'c','È' => 'E','É' => 'E','Ê' => 'E','Ë' => 'E','è' => 'e','é' => 'e','ê' => 'e','ë' => 'e','Ğ' => 'G','ğ' => 'g','Ì' => 'I','Í' => 'I','Î' => 'I','Ï' => 'I','İ' => 'I','ı' => 'i','ì' => 'i','í' => 'i','î' => 'i','ï' => 'i','Ñ' => 'N','Ò' => 'O','Ó' => 'O','Ô' => 'O','Õ' => 'O','Ö' => 'O','Ø' => 'O','ö' => 'o','ø' => 'o','ð' => 'o','ñ' => 'n','ò' => 'o','ó' => 'o','ô' => 'o','õ' => 'o','Š' => 'S','š' => 's','Ş' => 'S','ș' => 's','Ș' => 'S','ş' => 's','ß' => 'B','ț' => 't','Ț' => 'T','Ù' => 'U','Ú' => 'U','Û' => 'U','Ü' => 'U','ù' => 'u','ú' => 'u','û' => 'u','ü' => 'u','Ý' => 'Y','¥' => 'y','ý' => 'y','ý' => 'y','ÿ' => 'y','Ž' => 'Z','ž' => 'z' );
	//Replace all accented characters with regular characters
	$string = strtr($string, $replace);
	// Remove punctuation
	$string = preg_replace('/[^a-z|^A-Z|\s]|\^|\|/', '', $string);
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