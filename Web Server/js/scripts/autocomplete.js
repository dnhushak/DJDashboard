$(document).ready(function(){

	var songID = 0;
	var artistID = 0;
	var albumID = 0;
	var pGenreID = 0;
	var sGenreID = 0;
	var onairView = false;

	//FOR UPDATING
	var oldSongID = -1;
	var onairIndex = -1;

	$(".song-input-error").hide();

	for(var i = 1; i < genres.length; i++){
		$("#primary-genres-allowed").append('<option value="' + i + '">' + genres[i] + '</option>')
		$("#secondary-genres-allowed").append('<option value="' + i + '">' + genres[i] + '</option>')
	}
	$(".custom-song-button").on('click', function(){
		$('.custom-title').html("Add Custom Song");
        $('#onair').html('Add Song');
	});
	$(".close-custom-song").on('click', function(){

		$('#input-track').val("");
		$('#input-artist').val("");
		$('#input-album').val("");
		songID = 0;
		artistID = 0;
		albumID = 0;
		pGenreID = 0;
		sGenreID = 0;
		oldSongID = -1;
		onairIndex = -1;
		$(".song-input-error").hide();
	});

	$(".save-track").on('click', function(){
		if($('#input-track').val() != "" && $('#input-artist').val() != "" && $('#input-album').val() != ""){
			if($(this).attr('id') === 'onair'){
				onairView = true;
			}else{
				onairView = false;
			}
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
    getTrackDataForUpdate = function(trackID, songIndex){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getTrackData.php",
            data: { 'TrackID' : parseInt(trackID)}
        }).done(function(data){
            var songInfo;
            try{
                songInfo = JSON.parse(data);
            }catch(e){
                return;
            }
            songID = songInfo['TrackID'];
            $('#input-track').val(songInfo['TrackName']);
            artistID = songInfo['ArtistID'];
            $('#input-artist').val(songInfo['ArtistName']);
            albumID = songInfo['AlbumID'];
            $('#input-album').val(songInfo['AlbumName']);
            pGenreID = songInfo['PrimaryGenreID'];
            sGenreID = songInfo['SecondaryGenreID'];
            $('#primary-genres-allowed').val(pGenreID);
            $('#secondary-genres-allowed').val(sGenreID);

            onairIndex = songIndex;
            oldSongID = trackID;
        });
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
        	if(onairView){
        		var songName = $('#input-track').val();
        		var artistName = $('#input-artist').val();;
        		var albumName = $('#input-album').val();;
        		var pGenre = genres[parseInt($('#primary-genres-allowed').val())];
        		var sGenre = genres[parseInt($('#secondary-genres-allowed').val())];
        		var FCC = false;
        		var reco = false;
        		var tempTrack = new Track(songName, songID, reco, FCC, artistName, albumName, pGenre, sGenre);
        		var songHTML = '';
                songHTML += '<td>' + songName + '</td>';
                songHTML += '<td>' + artistName + '</td>';
                songHTML += '<td>' + albumName + '</td>';
                songHTML += '<td>' + pGenre + '</td>';
                songHTML += '<td>' + sGenre + '</td>';
        		if(oldSongID == -1 || onairIndex == -1){
	                songHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + onAirSongs.length + '">Mark Played</button></td>';
	                songHTML += '</td>';
	                onAirSongs.push(tempTrack);
	                $('.songs').append('<tr class="' + songID + '">' + songHTML);
        		}else{
        			songHTML += '<td><button type="button" class="btn btn-danger btn-sm" id="update-played" value="' + onairIndex + '" data-toggle="modal" data-target="#custom-song-modal">Update</button></td>';
	                tempTrack['PlayID'] = onAirSongs[onairIndex]['PlayID'];
        			onAirSongs[onairIndex] = tempTrack;
        			var trackShown = $('.' + oldSongID).first();
        			trackShown.html(songHTML);
        			trackShown.attr('class', '');
        			trackShown.addClass('' + songID);
        			trackShown.addClass('success');
        			updatePlayID(tempTrack['PlayID'], songID);
        		}
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
	var updatePlayID = function(playID, trackID){
		$.ajax({
            url: '../php/scripts/updatePlayByID.php',
            type: 'GET',
            data: { 'TrackID' : trackID,
        			'PlayID' : playID}
        }).done(function(data){
        	oldSongID = -1;
        	onairIndex = -1;
        });
	}
});