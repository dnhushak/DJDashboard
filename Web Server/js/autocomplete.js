$(document).ready(function(){

	var songID = 0;
	var artistID = 0;
	var albumID = 0;
	var pGenreID = 0;
	var sGenreID = 0;

	$(".save-track").on('click', function(){
		if($('#input-track').val() != "" && $('#input-artist').val() != "" && $('#input-album').val() != ""){
			customArtist();
		}else{

		}
	})

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
		$('#input-artist').val(artists[parseInt(datum['Artist'])]['Name']);
		$('#input-album').val(albums[parseInt(datum['Album'])]['Name']);
		$('#primary-genres-allowed').val(datum['PrimaryGenreID']);
		$('#secondary-genres-allowed').val(datum['SecondaryGenreID']);

		songID = datum['TrackID'];
		artistID = datum['Artist'];
		albumID = datum['Album'];
		pGenreID = $('#primary-genres-allowed').val();
		sGenreID = $('#secondary-genres-allowed').val();
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
	var customArtist = function(){
		$.ajax({
            url: '../php/scripts/insertCustomArtist.php',
            type: 'GET',
            data: {'ArtistName' : $('#input-artist').val()}
        }).done(function(addedID){
        	artistID = parseInt(addedID);
        	customAlbum();
        })

	}
	var customAlbum = function(){
		$.ajax({
            url: '../php/scripts/insertCustomAlbum.php',
            type: 'GET',
            data: {'AlbumName' : $('#input-album').val(),
        			'ArtistID' : artistID,
        			'PGenre' : pGenreID,
        			'SGenre' : sGenreID}
        }).done(function(addedID){
        	console.log(addedID);
        	albumID = parseInt(addedID);
        	customTrack();
        })

	}
	var customTrack = function(){
		$.ajax({
            url: '../php/scripts/insertCustomTrack.php',
            type: 'GET',
            data: {'TrackName' : $('#input-track').val(),
        			'ArtistID' : artistID,
        			'AlbumID' : albumID,
        			'PrimaryGenreID' : pGenreID,
        			'SecondaryGenreID' : sGenreID}
        }).done(function(addedID){
        	songID = parseInt(addedID);
        	$('#custom-song-modal').modal('hide');
        	$('.playlist').append('<li class="playlist-song ' + songID + '"><img class="pl-button delete-playlist" src="../resources/delete.png">' + $('#input-track').val() + '</li>');
        })
	}
});