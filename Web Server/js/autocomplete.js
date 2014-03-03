$(document).ready(function(){

	var tracks = new Bloodhound({
		datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.TrackName); },
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		remote: '../php/scripts/searchTrack.php?query=%QUERY',
		limit: 15
	});

	tracks.initialize();

	$('#input-track').typeahead({
		minLength: 2,
		highlight: true
	}, 
	{
		displayKey: 'TrackName',
		source: tracks.ttAdapter(),
	});
	$('#input-track').bind('typeahead:selected', function(obj, datum, name){
		$('#input-track').val(datum['TrackName']);
		$('#input-track-id').html(datum['TrackID']);
		console.log($('#input-track-id').html());
		$('#input-artist').val(artists[parseInt(datum['Artist'])]['Name']);
		$('#input-artist-id').html(datum['Artist']);
		$('#input-album').val(albums[parseInt(datum['Album'])]['Name']);
		$('#input-album-id').html(datum['Album']);
		$('#primary-genres-allowed').val(datum['PrimaryGenreID']);
		$('#secondary-genres-allowed').val(datum['SecondaryGenreID']);
	});

	var arts = new Bloodhound({
		datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.ArtistName); },
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		remote: '../php/scripts/searchArtists.php?query=%QUERY',
		limit: 15
	});

	arts.initialize();

	$('#input-artist').typeahead({
		minLength: 2,
		highlight: true
	}, 
	{
		displayKey: 'ArtistName',
		source: arts.ttAdapter(),
	});
	var albs = new Bloodhound({
		datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.AlbumName); },
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		remote: '../php/scripts/searchAlbums.php?query=%QUERY',
		limit: 15
	});

	albs.initialize();

	$('#input-album').typeahead({
		minLength: 2,
		highlight: true
	}, 
	{
		displayKey: 'AlbumName',
		source: albs.ttAdapter(),
	});
});