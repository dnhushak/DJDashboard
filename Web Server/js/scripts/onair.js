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
            for(var i = 0; i < tracks.length; i++){
                var songHTML = '<tr class="' + tracks[i]['TrackID'] + '">';
                songHTML += '<td>' + tracks[i]['TrackName'] + '</td>';
                songHTML += '<td>' + tracks[i]['Artist']['ArtistName'] + '</td>';
                songHTML += '<td>' + tracks[i]['Album']['AlbumName'] + '</td>';
                songHTML += '<td>' + genres[parseInt(tracks[i]['PrimaryGenreID'])] + '</td>';
                songHTML += '<td>' + genres[parseInt(tracks[i]['SecondaryGenreID'])] + '</td>';
                songHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played">Mark Played</button></td>';
                songHTML += '</td>';
                $('.songs').append(songHTML);
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
        console.log(songID);
        $(this).parent().parent().addClass('success');
        $(this).text('Played');
        $(this).attr('disabled', 'disabled');
    })
});