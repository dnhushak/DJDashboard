$(document).ready(function(){

	var tracks = new Bloodhound({
		datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.num); },
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		remote: '../php/scripts/searchTrack.php?query=%QUERY',
	});

	tracks.initialize();

	$('#input-track').typeahead({
		minLength: 2
	}, 
	{
		displayKey: 'TrackName',
		source: numbers.ttAdapter()
	});
	$('#input-track').bind('typeahead:selected', function(obj, datum, name){
		$('#input-artist').val(artists[parseInt(datum['Artist'])]['Name']);
		$('#input-album').val(albums[parseInt(datum['Album'])]['Name']);
		$('#primary-genres-allowed').val(datum['PrimaryGenreID']);
		$('#secondary-genres-allowed').val(datum['SecondaryGenreID']);
	});
});