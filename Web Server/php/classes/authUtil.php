<?php

/**
	 * Consists of a variety useful static functions
	 */
class authUtil {

	/**
	 * Creates a random salt of length $size
	 *
	 * @param
	 *        	size - the length of salt
	 * @return string
	 *
	 */
	public static function makeSalt($size){
		return mcrypt_create_iv($size, MCRYPT_DEV_URANDOM);
	}

	/**
	 * Makes a hashed password with salt
	 *
	 * @param
	 *        	string password
	 * @param
	 *        	string username
	 * @param
	 *        	salt user's salt
	 *        	
	 */
	public static function makePassHash($algo, $salt, $username, $password){
		$hash = hash($algo, $salt . $username . $password);
		return $hash;
	}

	/**
	 *
	 * @return true if the hash password matches with the hash for the username and password
	 *        
	 */
	public static function verifyPass($algo, $hash, $salt, $username, $password){
		$attempt = authUtil::makePassHash($algo, $salt, $username, $password);
		// Slow equals, so check functions in linear time (more secure than traditional equals)
		// Checks if the same size (continues to check equality anyway, for constant time)
		$diff = strlen($hash) ^ strlen($attempt);
		// Iterates through every character and OR's the XOR'ed value of both string's characters at that iterative point
		for($i = 0; $i < strlen($hash) && $i < strlen($attempt); $i++) {
			$diff |= ord($hash [$i]) ^ ord($attempt [$i]);
		}
		// Return whether or not the strings are different
		return $diff === 0;
	}
}