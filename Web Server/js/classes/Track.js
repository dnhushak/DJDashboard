/**
 * Track Class
 * @param {str} name - Name of track
 * @param {int} id -  Id of track
 * @param {bool} reco - is reccomended
 * @param {bool} FCC - is explicit
 */
function Track (name, id, reco, FCC, artistName, albumName, pGenre, sGenre) {
	this.Name = name;
	this.ID = id;
	this.reco = reco;
	this.FCC = FCC;
	this.Artist = artistName;
	this.Album = albumName;
	this.PrimaryGenre = pGenre;
	this.SecondaryGenre = sGenre;
}