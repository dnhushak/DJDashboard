/**
 * Artist class
 * @param {String} name      name of the artist
 * @param {Integer} id       id of the artist  
 */
function Artist (name, id) {
	this.name = name
	this.id = id;
	this.albums = new Array();
	/**
	 * Add album to this artist, will only add if album is not in the artist already
	 * @param {str} name  	album name
	 * @param {[int} id   	album id
	 */
	this.addAlbum = function(name, id, genre1, genre2){
		if(!containsAlbum(id))
			tracks.push(new Album(name, id, genre1, genre2));
	}
	/**
	 * Sees if the artist contains an album specifed by the album id
	 * @param  {int} id 	id of the album to find
	 * @return {bool}		true if album is in album false if not    	
	 */
	this.containsTrack = function(id){
		for (var i = 0; i < albums.length; i++) {
			if(albums[i].id == id){
				return true;
			}
		}
		return false;
	}
}