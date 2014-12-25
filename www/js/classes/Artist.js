/**
 * Artist class
 * @param {String} name      name of the artist
 * @param {Integer} id       id of the artist  
 */
function Artist (name, id) {
	this.Name = name
	this.ID = id;
	this.albums = new Array();
	/**
	 * Add album to this artist, will only add if album is not in the artist already
	 * @param {str} name  	album name
	 * @param {[int} id   	album id
	 */
	this.addAlbum = function(album){
		if(!this.containsAlbum(album['ID']))
			this.albums.push(album);
	}
	/**
	 * Sees if the artist contains an album specifed by the album id
	 * @param  {int} id 	id of the album to find
	 * @return {bool}		true if album is in album false if not    	
	 */
	this.containsAlbum = function(id){
		for (var i = 0; i < this.albums.length; i++) {
			if(this.albums[i]['ID'] == id){
				return true;
			}
		}
		return false;
	}
}