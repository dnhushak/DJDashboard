/**
 * @requires Track.js
 * Album class
 * @param {String} name   Album name
 * @param {Integer} id    Album ID from db
 * @param {String} genre1 Primary Genre
 * @param {String} genre2 Secondary Genre
 */
function Album(name, id, genre1, genre2) {
	this.Name = name;
	this.ID = id;
	this.Genre1 = genre1;
	this.Genre2 = genre2;
	this.tracks = new Array();
	/**
	 * Add track to this album, will only add if track is not in the ablum already
	 * @param {Track} track  	track to add to album
	 */
	this.addTrack = function(track){
		if(!this.containsTrack(track['ID']))
			this.tracks.push(track);
	}
	/**
	 * Sees if the album contains a track specifed by the track id
	 * @param  {int} id 	id of the track to fine
	 * @return {bool}		true if track is in album false if not    	
	 */
	this.containsTrack = function(id){
		for (var i = 0; i < this.tracks.length; i++) {
			if(this.tracks[i]['ID'] == id){
				return true;
			}
		}
		return false;
	}
}