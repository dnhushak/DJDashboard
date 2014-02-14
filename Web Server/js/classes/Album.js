/**
 * @requires Track.js
 * Album class
 * @param {String} name   Album name
 * @param {Integer} id    Album ID from db
 * @param {String} genre1 Primary Genre
 * @param {String} genre2 Secondary Genre
 */
function Album (name, id, genre1, genre2) {
	this.name = name;
	this.id = id;
	this.genre1 = genre1;
	this.genre2 = genre2;
	this.tracks = new Array();
	/**
	 * Add track to this album, will only add if track is not in the ablum already
	 * @param {str} name  	track name
	 * @param {[int} id   	track id
	 * @param {bool} reco 	is recomended
	 * @param {bool} FCC  	is explicit
	 */
	this.addTrack = function(name, id, reco, FCC){
		if(!containsTrack(id))
			tracks.push(new Track(name, id, reco, FCC));
	}
	/**
	 * Sees if the album contains a track specifed by the track id
	 * @param  {int} id 	id of the track to fine
	 * @return {bool}		true if track is in album false if not    	
	 */
	this.containsTrack = function(id){
		for (var i = 0; i < tracks.length; i++) {
			if(tracks[i].id == id){
				return true;
			}
		}
		return false;
	}
}