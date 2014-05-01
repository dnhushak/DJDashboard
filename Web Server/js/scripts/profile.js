/**
 * Manages the profiles
 */

$('document').ready(function() {

	var getCurrentUsersProfile = function() {
		$.ajax({
			type : "GET",
			url : "../php/scripts/getCurrentUserProfile.php"
		}).done(function(data) {
			var profile;
			try {
				profile = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}
			var djNickName = profile['NickName'];
			var djMotto = profile['Motto'];
			var djBio = profile['Bio'];
			var djID = profile['UserID'];
			
			
			
			if(djBio != ""){
				$('#bio').append(djBio);
			}
			
			if(djID != ""){
				console.log('../resources/' + djID + '.jpg');
				$('#djTitle').append('<img id="djThumbnail" class="img-thumbnail" src="../resources/' + djID + '.jpg" width="70" height="70">')
			}
			else
			{
				
				$('#djTitle').append('<img id="djThumbnail" class="img-thumbnail" src="../resources/kittyAvatar.jpg" width="70" height="70">')
				
			}
			if(djNickName != ""){
				$('#djTitle').append(djNickName + " <small> " + djMotto + "</small>");
			}
			
			
		});
	}

	var getFivePlaylists = function() {
		$.ajax({
			type : "GET",
			url : "../php/scripts/GetProfilePlaylists.php"
		}).done(function(data) {
			var profile;
			try {
				playlists = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}
			console.log('getfive');
			var panelHTML = '';
			for ( var i = 0; i < playlists.length; i++) {
				//Create playlist drop down
				var playlistName = playlists[i]['PlaylistName'];
				var playlistID = playlists[i]['PlaylistID'];
				panelHTML = panelHTML + '<div class="panel panel-default"><div class="panel-heading"><h4 class="panel-title"><a data-toggle="collapse" href="#playlist' + playlistID + '">' + playlistName + '</a></h4></div><div id="playlist' + playlistID + '" class="panel-collapse collapse">';
				panelHTML = panelHTML + '<div class="panel-body"><ul>';
				for ( var j = 0; j < playlists[i]['Tracks'].length; j++) {
					//Create songs in that drop down
					console.log(playlists[i][j]);
					var trackName = playlists[i]['Tracks'][j]['TrackName'];
					var artistName = playlists[i]['Tracks'][j]['Artist']['ArtistName'];
					var songHTML = '<li><a href="#">' + trackName + ' - ' + artistName + '</a></li>';
					panelHTML = panelHTML + songHTML;
				}
				panelHTML = panelHTML + '</ul></div></div></div></div>'
			}
			$('#spinlist-dropdown').append(panelHTML);
		});

		/***********************************************************************
		 * <div class="panel-body">
		 * <ul>
		 * <li><a href="#">Song One</a></li>
		 * <li><a href="#">Song Two</a></li>
		 * <li><a href="#">Song Three</a></li>
		 * <li><a href="#">Song Four</a></li>
		 * <li><a href="#">Song Five</a></li>
		 * </ul>
		 * </div>
		 **********************************************************************/
	}

	getCurrentUsersProfile();
	getFivePlaylists();
});
