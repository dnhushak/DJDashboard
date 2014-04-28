<?php
include_once '../sqlconnect.php';
include_once 'Artist.php';
include_once 'Album.php';
include_once 'Track.php';
include_once 'Genre.php';
include_once '../publisher.php';

class MusicDirector {
	// Get albums by distributor
	// Get distributor list
	// set distributor by ID
	// getusersbypermission
	// set album reviewer by id
	// Add Album to rotation
	// Remove album from rotation (but not from the library!)
	//
	private $spAddDistributor;
	private $spAddRotation;
	private $spGetAllDistributors;
	private $spGetDistributorByID;
	private $spGetAlbumsFromDistributorID;
	private $spGetReviewers;
	private $spGetRotation;
	private $spAssignReviewer;
	private $spReviewAlbum;
	private $conn;

	public function __construct(){
		$this->initialize();
	}

	/**
	 * Build constant procedure names
	 */
	private function initialize(){
		// Register failure procedure
		register_shutdown_function("Publisher::fatalHandler");
		$conn = new sqlConnect();
		
		$this->spAddDistributor = "AddDistributor";
		$this->spAddRotation = "AddRotation";
		$this->spGetAllDistributors = "GetAllDistributors";
		$this->spGetDistributorByID = "GetDistributorByID";
		$this->spGetAlbumsFromDistributorID = "GetAlbumsFromDistributorID";
		$this->spGetReviewers = "GetReviewers";
		$this->spGetRotation = "GetRotation";
		$this->spAssignReviewer = "AssignReviewer";
		$this->spReviewAlbum = "ReviewAlbum";
	}

	public function addDistributor($distributorName, $phone, $email, $contactName, $location, $affiliated, $website, $downloadSite, $weight){
		try {
			$args = array ();
			$args [] = $phone;
			$args [] = $email;
			$args [] = $contactName;
			$args [] = $location;
			$args [] = $affiliated;
			$args [] = $website;
			$args [] = $downloadSite;
			$args [] = $weight;
			$results = $this->conn->callStoredProc($this->spAddDistributor, $args);
		}
		catch (Exception $e) {
			Publisher::publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}
	}

	public function addRotation($distributorID, $albumID, $comments){
	}

	public function getAllDistributors(){
		try{
			$results = $this->conn->callStoredProd($this->spGetAllDistributors, NULL);
		}
		catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}
	}
}
?>