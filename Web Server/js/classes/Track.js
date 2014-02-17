/**
 * Track Class
 * @param {str} name - Name of track
 * @param {int} id -  Id of track
 * @param {bool} reco - is reccomended
 * @param {bool} FCC - is explicit
 */
function Track (name, id, reco, FCC) {
	this.Name = name;
	this.ID = id;
	this.reco = reco;
	this.FCC = FCC;
}