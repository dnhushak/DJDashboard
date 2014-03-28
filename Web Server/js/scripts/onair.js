$('document').ready(function(){

    getGrants = function(){
        $.ajax({
            type: "GET",
            data: {'Count': 25},
            url: "../php/scripts/getGrants.php"
        }).done(function(data){
            console.log(data);
            var grants;
            try{
                grants = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            console.log(grants);
            $('.grants').html('');
            for(var i = 0; i < grants.length; i++){
                var grantHTML = '<div class="panel panel-default"><div class="panel-heading"><h4 class="panel-title">'
                grantHTML += '<a data-toggle="collapse" data-parent="#accordion" href="#collapse' + i + '" class=' + grants[i]['GrantID'] + '>';
                grantHTML += grants[i]['GrantName'] + '</a></h4></div>';
                grantHTML += '<div id="collapse' + i + '" class="panel-collapse collapse"><div class="panel-body">';
                grantHTML += grants[i]['Message'];
                grantHTML += '<button style="float: right;" type="button" class="btn btn-primary custom-song-button btn-sm" data-toggle="modal" data-target="#custom-song-modal">Mark Read</button></div></div></div>'
                $('.grants').append(grantHTML);
            }
        });
    }

    getRecentlyPlayed = function(){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getRecentlyPlayed.php"
        }).done(function(data){
            var tracks;
            try{
                tracks = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            $('.recently-played').html('');
            for(var i = 0; i < tracks.length; i++){
                $('.recently-played').append('<li class="list-group-item">' + tracks[i]['TrackName'] + ' - ' + tracks[i]['Artist'] +'</li>')
            }
        });
    }

    getAllPlaylists = function(){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getPlaylistIDByUser.php"
        }).done(function(data){
            var lists;
            try{
                lists = JSON.parse(data);
            }catch(e){
                PublishError(e);
                return;
            }
            $('#all-playlists').html('');
            for(var i = 0; i < lists.length; i++){
                $('#all-playlists').append('<li class="list-group-item"><span class="playlist-name">' + lists[i]['PlaylistName'] + '</span>' +
                                            '<button style="float: right;" type="button" class="btn btn-xs btn-primary" id="load-playlist"' + 
                                            'value="' + lists[i]['PlaylistID'] + '">Load</button></li>');
            }
        });
    }
    loadPlaylist = function(playlistID){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getPlaylistByID.php",
            data: {"PlaylistID" : playlistID}
        }).done(function(data){
            var tracks;
            try{
                tracks = JSON.parse(data);
            }catch(e){
                PublishError(e);
                return;
            }
            $('.songs').html('');
            onAirSongs = new Array();
            for(var i = 0; i < tracks.length; i++){
                var songID = tracks[i]['TrackID'];
                var songName = tracks[i]['TrackName'];
                var artistName = tracks[i]['Artist']['ArtistName'];
                var albumName = tracks[i]['Album']['AlbumName'];
                var pGenre = genres[parseInt(tracks[i]['PrimaryGenreID'])];
                var sGenre = genres[parseInt(tracks[i]['SecondaryGenreID'])];
                var reco = tracks[i]['Recommended'];
                var FCC = tracks[i]['FCC'];
                var tempTrack = new Track(songName, songID, reco, FCC, artistName, albumName, pGenre, sGenre);
                var songHTML = '<tr class="' + songID + '">';
                songHTML += '<td>' + songName + '</td>';
                songHTML += '<td>' + artistName + '</td>';
                songHTML += '<td>' + albumName + '</td>';
                songHTML += '<td>' + pGenre + '</td>';
                songHTML += '<td>' + sGenre + '</td>';
                songHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + onAirSongs.length + '">Mark Played</button></td>';
                songHTML += '</td>';
                $('.songs').append(songHTML);
                onAirSongs.push(tempTrack);
            }
            $('#load-modal').modal('hide');
        });
    }

    markPlayedTrack = function(trackID, songIndex){
        $.ajax({
            type: "GET",
            url: "../php/scripts/playTrackByID.php",
            data: {"TrackID" : trackID}
        }).done(function(data){
            var playID;
            try{
                playID = JSON.parse(data)['PlayID'];
                onAirSongs[songIndex]['PlayID'] = playID;
                getRecentlyPlayed();
            }catch(e){
                PublishError(e);
                return;
            }
        });
    }

    $('.load-playlist-button').on('click', function(){
        getAllPlaylists();
    });
    $(document).on('click', '#load-playlist', function(){
        var playlistID = $(this).val();
        var playlistName = $(this).parent().find('.playlist-name').text();
        $('#playlist-name').val(playlistName);
        loadPlaylist(playlistID);
    });
    $(document).on('click', '#mark-played', function(){
        var songID = $(this).parent().parent().attr('class');
        var songIndex = parseInt($(this).val());
        $(this).parent().parent().addClass('success');
        $(this).text('Update');
        $(this).removeClass('btn-primary');
        $(this).addClass('btn-danger');
        $(this).attr('id', 'update-played');
        $(this).attr("data-toggle", "modal");
        $(this).attr("data-target", "#custom-song-modal");
        markPlayedTrack(songID, songIndex);
    });

    $(document).on('click', '#update-played', function(){
        console.log($(this).parent().parent().html());
        $('.custom-title').html("Update Song");
        $('#onair').html('Update');
        getTrackDataForUpdate($(this).parent().parent().attr('class').match(/\d+/), $(this).val());
    });
    $('#onair').on('click', function(){
        setTimeout(function(){getRecentlyPlayed();}, 500);
    });

    getRecentlyPlayed();
    getGrants();
    for(var i = 0; i < onAirSongs.length; i++){
        var songID = onAirSongs[i]['ID'];
        var songName = onAirSongs[i]['Name'];
        var artistName = onAirSongs[i]['Artist'];
        var albumName = onAirSongs[i]['Album'];
        var pGenre = onAirSongs[i]['PrimaryGenre'];
        var sGenre = onAirSongs[i]['SecondaryGenre'];
        var reco = onAirSongs[i]['reco'];
        var FCC = onAirSongs[i]['FCC'];
        var songHTML;
        if(onAirSongs[i]['PlayID'] != 0){
            songHTML = '<tr class="success ' + songID + '">';
        }else{
            songHTML = '<tr class="' + songID + '">';
        }
        songHTML += '<td>' + songName + '</td>';
        songHTML += '<td>' + artistName + '</td>';
        songHTML += '<td>' + albumName + '</td>';
        songHTML += '<td>' + pGenre + '</td>';
        songHTML += '<td>' + sGenre + '</td>';
        if(onAirSongs[i]['PlayID'] != 0){
            songHTML += '<td><button type="button" class="btn btn-danger btn-sm" id="update-played" value="' + i + '" data-toggle="modal" data-target="#custom-song-modal">Update</button></td>';
        }else{
            songHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + i + '">Mark Played</button></td>';
        }
        songHTML += '</td>';
        $('.songs').append(songHTML);
    }
});