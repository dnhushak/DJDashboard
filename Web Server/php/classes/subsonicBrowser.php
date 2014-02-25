<?php
include_once ('../library/Track.php');

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

	private function sendRequest($request, $args, $binary){
		$rest = $this->url . 'rest/' . $request . '.view?';
		$args ['u'] = $this->user;
		$args ['p'] = $this->pass;
		$args ['v'] = $this->version;
		$args ['c'] = $this->apiname;
		$args ['f'] = $this->format;
		foreach (array_keys($args) as $key) {
			$arg = urlencode($args [$key]);
			$rest = $rest . $key . '=' . $arg . '&';
		}
		//echo $rest . "<br/>";
		$session = curl_init($rest);
		if ($binary) {
			curl_setopt($session, CURLOPT_BINARYTRANSFER, 1);
		}
		curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
		// Execute cURL on the session handle
		$response = curl_exec($session);
		// Close the cURL session
		curl_close($session);
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

	public function getTracksByArtist($artistid){
		$args = array (
				"id" => $artistid );
	}

	public function getTracksByAlbum($albumid){
		$args = array (
				"id" => $albumid );
		$tracks = $this->sendRequest("getAlbum", $args, FALSE);
		$tracks = json_decode($tracks, true);
		//var_dump($tracks["subsonic-response"]["album"]["song"]["id"]);
		// var_dump($tracks);
		foreach ($tracks ["subsonic-response"] ["album"]["song"] as $track) {
			//foreach ($tracklist["song"] as $track){
			//var_dump($tracklist);
			//echo $tracklist ["id"];
			//echo $track ["id"] . "::" . $track ["title"] . "<Br/>";
			/*$trackrow = array (
					"id" => $track ["id"],
					"name" => $track ["title"] );
			$tracklist [] = $trackrow;*/
			//}
			var_dump($track);
		}
		return $tracklist;
	}

	public function getAlbumsByArtist($artistid){
		$args = array (
				"id" => $artistid );
		$albums = $this->sendRequest("getArtist", $args, FALSE);
		$albums = json_decode($albums, true);
		foreach ($albums ["subsonic-response"] ["artist"] ["album"] as $album) {
			$albumrow = array (
					"id" => $album ["id"],
					"name" => $album ["name"] );
			$albumlist [] = $albumrow;
		}
		return $albumlist;
	}

	public function getArtists(){
		$artists = $this->sendRequest(getArtists, NULL, FALSE);
		return $artists;
	}

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

	public function getTrackByNames(Track $track){
	}
}
?>