<?php
include_once ('../library/Track.php');
include_once('../publisher.php');

final class subsonicBrowser {
	private $url;
	private $user;
	private $pass;
	private $version;
	private $apiname;
	private $format;

	public function __Construct($url, $user, $pass, $version, $apiname, $format){
		$this->url = $url;
		$this->user = $user;
		$this->pass = $pass;
		$this->version = $version;
		$this->apiname = $apiname;
		$this->format = $format;
	}

	/**
	 * Sends the cURL request to the subsonic server at $this->url
	 *
	 * @param string $request
	 *        	Request name, such as getArtist or getAlbum
	 * @param array $args
	 *        	Associative array of GET variables, where key is variable name and value is variable value
	 * @param boolean $binary
	 *        	TRUE if return will be a binary output (mp3 stream or download), defaults to FALSE
	 * @return mixed The json, xml, or binary output of the cURL request
	 */
	private function sendRequest($request, $args, $binary = FALSE){
		
		// http://path.to.server/rest/requestName.view?
		$rest = $this->url . 'rest/' . $request . '.view?';
		
		// Add the required credential variables to the args array
		$args ['u'] = $this->user;
		$args ['p'] = $this->pass;
		$args ['v'] = $this->version;
		$args ['c'] = $this->apiname;
		$args ['f'] = $this->format;
		
		// Put each arg in the url as key=arg&
		foreach (array_keys($args) as $key) {
			$arg = urlencode($args [$key]);
			$rest = $rest . $key . '=' . $arg . '&';
		}
		
		// Debug
		// echo $rest . "<br/>";
		
		// Start cURL session
		$session = curl_init($rest);
		
		// Check for binary flag
		if ($binary) {
			curl_setopt($session, CURLOPT_BINARYTRANSFER, 1);
		}
		// Tell cURL to return the transfer info
		curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
		
		// Execute cURL on the session handle
		$response = curl_exec($session);
		
		// Close the cURL session
		curl_close($session);
		
		// Return the cURL response data
		return $response;
	}

	public function ping(){
		
		$ping = $this->sendRequest("ping", NULL, NULL);
		$ping = json_decode($ping, true);
		if ($ping ["subsonic-response"] ["status"] == "ok") {
			return TRUE;
		}
		else {
			return FALSE;
		}
	}
	
	// TODO: Finish this
	public function getTracksByArtist($artistid){
		$args = array (
				"id" => $artistid );
	}

	public function getTracksByAlbum($albumid){
		// Set args
		$args = array (
				"id" => $albumid );
		
		// Send request
		$tracks = $this->sendRequest("getAlbum", $args, FALSE);
		
		// encode JSON
		$tracks = json_decode($tracks, true);
		
		// Subsonic REST API spits out songs as an array of associative arrays if songcount >1,
		// If soungcount == 1, it just gives an associative array. *HEAD-DESK*
		$songCount = $tracks ["subsonic-response"] ["album"] ["songCount"];
		$tracklist = array();
		if ($songCount != 1) {
			// Go through each array of songs
			foreach ($tracks ["subsonic-response"] ["album"] ["song"] as $track) {
				
				// Grab id and title
				$trackrow = array (
						"id" => $track ["id"],
						"name" => $track ["title"] );
				$tracklist [] = $trackrow;
			}
		}
		else {
			// Grab the singular song array
			$track = $tracks ["subsonic-response"] ["album"] ["song"];
			
			// Grab id and title
			$trackrow = array (
					"id" => $track ["id"],
					"name" => $track ["title"] );
			$tracklist [] = $trackrow;
		}
		return $tracklist;
	}

	public function getAlbumsByArtist($artistid){
		$args = array (
				"id" => $artistid );
		$albums = $this->sendRequest("getArtist", $args, FALSE);
		$albums = json_decode($albums, TRUE);
		foreach ($albums ["subsonic-response"] ["artist"] ["album"] as $album) {
			$albumrow = array (
					"id" => $album ["id"],
					"name" => $album ["name"] );
			$albumlist [] = $albumrow;
		}
		return $albumlist;
	}
	// TODO: make this return an associative array of id=>artist name
	public function getArtists(){
		$artists = $this->sendRequest("getArtists", NULL, FALSE);
		return $artists;
	}
	// TODO: update to use the getArtists new return type
	public function getArtistidByName($artist){
		$artists = $this->getArtists();
		$artists = json_decode($artists, TRUE);
		$artistid;
		foreach ($artists ["subsonic-response"] ["artists"] ["index"] as $val) {
			foreach ($val ["artist"] as $index) {
				if ($artist == $index ["name"]) {
					$artistid = $index ["id"];
					break 2;
				}
			}
		}
		if (is_null($artistid)) {
			return FALSE;
		}
		else {
			return $artistid;
		}
	}

	public function getTrackidByNames($artist, $album, $track){
		$artistID = $this->getArtistidByName($artist);
		$albumList = $this->getAlbumsByArtist($artistID);
		$albumID;
		foreach ($albumList as $alb){
			if($alb["name"] == $album){
				$albumID = $alb["id"];
				break;
			}
		}
		$trackList = $this->getTracksByAlbum($albumID);
		foreach ($trackList as $trk) {
			if($trk['name'] == $track){
				return $trk['id'];
			}
		}
	}
	public function getTrackPlayLinkByNames($artist, $album, $track){
		$trackID = $this->getTrackidByNames($artist, $album, $track);
		$trackURL = $this->url . 'rest/stream.view?';
		
		// Add the required credential variables to the args array
		$args ['u'] = $this->user;
		$args ['p'] = $this->pass;
		$args ['v'] = $this->version;
		$args ['c'] = $this->apiname;
		$args ['f'] = $this->format;
		
		// Put each arg in the url as key=arg&
		foreach (array_keys($args) as $key) {
			$arg = urlencode($args [$key]);
			$trackURL = $trackURL . $key . '=' . $arg . '&';
		}
		return $trackURL . "id=" . $trackID . "&format=mp3"; 
	}
}
?>