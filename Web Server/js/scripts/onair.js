$('document').ready(function(){

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
    $('.load-playlist-button').on('click', function(){
        getAllPlaylists();
    });
    $(document).on('click', '#load-playlist', function(){
        var playlistID = $(this).val();
        var playlistName = $(this).parent().find('.playlist-name').text();
        $('#playlist-name').val(playlistName);
        loadPlaylist(playlistID);
    })
    $(document).on('click', '#mark-played', function(){
        var songID = $(this).parent().parent().attr('class');
        onAirSongs[parseInt($(this).val())]['Played'] = true;
        $(this).parent().parent().addClass('success');
        $(this).text('Update');
        $(this).removeClass('btn-primary');
        $(this).addClass('btn-danger');

    })

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
        if(onAirSongs[i]['Played']){
            songHTML = '<tr class="success ' + songID + '">';
        }else{
            songHTML = '<tr class="' + songID + '">';
        }
        songHTML += '<td>' + songName + '</td>';
        songHTML += '<td>' + artistName + '</td>';
        songHTML += '<td>' + albumName + '</td>';
        songHTML += '<td>' + pGenre + '</td>';
        songHTML += '<td>' + sGenre + '</td>';
        if(onAirSongs[i]['Played']){
            songHTML += '<td><button disabled="disabled" type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + onAirSongs.length + '">Played</button></td>';
        }else{
            songHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + onAirSongs.length + '">Mark Played</button></td>';
        }
        songHTML += '</td>';
        $('.songs').append(songHTML);
    }
});