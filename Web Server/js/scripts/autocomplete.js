$(document).ready(function(){

	var songID = 0;
	var artistID = 0;
	var albumID = 0;
	var pGenreID = 0;
	var sGenreID = 0;
	var onairView = false;

	$(".song-input-error").hide();

	for(var i = 1; i < genres.length; i++){
		$("#primary-genres-allowed").append('<option value="' + i + '">' + genres[i] + '</option>')
		$("#secondary-genres-allowed").append('<option value="' + i + '">' + genres[i] + '</option>')
	}

	$(".close-custom-song").on('click', function(){
		$('#input-track').val("");
		$('#input-artist').val("");
		$('#input-album').val("");
		songID = 0;
		artistID = 0;
		albumID = 0;
		pGenreID = 0;
		sGenreID = 0;
		$(".song-input-error").hide();
	});

	$(".save-track").on('click', function(){
		if($('#input-track').val() != "" && $('#input-artist').val() != "" && $('#input-album').val() != ""){
			if($(this).attr('id') === 'onair'){
				onairView = true;
			}else{
				onairView = false;
			}
			console.log(onairView);
			customArtist();
		}else{
			$(".song-input-error").show();
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
        	songID = addedID;
        	if(onairView){
        		var songName = $('#input-track').val();
        		var artistName = $('#input-artist').val();;
        		var albumName = $('#input-album').val();;
        		var pGenre = genres[parseInt($('#primary-genres-allowed').val())];
        		var sGenre = genres[parseInt($('#secondary-genres-allowed').val())];
        		var FCC = false;
        		var reco = false;
        		var tempTrack = new Track(songName, songID, reco, FCC, artistName, albumName, pGenre, sGenre);
        		var songHTML = '<tr class="' + songID + '">';
                songHTML += '<td>' + songName + '</td>';
                songHTML += '<td>' + artistName + '</td>';
                songHTML += '<td>' + albumName + '</td>';
                songHTML += '<td>' + pGenre + '</td>';
                songHTML += '<td>' + sGenre + '</td>';
                songHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + onAirSongs.length + '">Mark Played</button></td>';
                songHTML += '</td>';
                onAirSongs.push(tempTrack);
                $('.songs').append(songHTML);
        	}else{
	        	$('.playlist').append('<li class="playlist-song ' + songID + '"><img class="pl-button delete-playlist" src="../resources/delete.png">' + $('#input-track').val() + '</li>');
        	}
        	$('#custom-song-modal').modal('hide');
			$('#input-track').val("");
			$('#input-artist').val("");
			$('#input-album').val("");
			songID = 0;
			artistID = 0;
			albumID = 0;
			pGenreID = 0;
			sGenreID = 0;
			$(".song-input-error").hide();
        });
	}
});