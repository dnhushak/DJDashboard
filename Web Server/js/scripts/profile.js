/**
 * Manages the profiles
 */


$('document').ready(function(){
	
	
	var getCurrentUsersProfile = function(){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getCurrentUserProfile.php"
        }).done(function(data){
            var profile;
            try{
                profile = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            var djNickName = profile['NickName'];
            var djMotto = profile['Motto'];
            var djBio = profile['Bio'];
            for (var i = 0; i < profile.length; i++) {
            
            }
            
            
            
        });
    }
	
	var getFivePlaylists = function(){
		$.ajax({
            type: "GET",
            url: "../php/scripts/GetProfilePlaylists.php"
        }).done(function(data){
            var profile;
            try{
                profile = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            var trackName = profile['TrackName'];
            var djMotto = profile['Motto'];
            var djBio = profile['Bio'];
            
            if(djNickName != ""){
                $('#djTitle').append(djNickName + " <small> " + djMotto + "</small>");
            }
            if(djBio != ""){
            	$('#bio').append(djBio);
            }
            
            
        });
		
		/**
		<div class="panel-body">
		<ul>
			<li><a href="#">Song One</a></li>
			<li><a href="#">Song Two</a></li>
			<li><a href="#">Song Three</a></li>
			<li><a href="#">Song Four</a></li>
			<li><a href="#">Song Five</a></li>
		</ul>
		</div>**/
	}
	
	getCurrentUsersProfile();
});

