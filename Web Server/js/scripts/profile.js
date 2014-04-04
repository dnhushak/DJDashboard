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
            
            if(djNickName != ""){
                $('#djTitle').append(djNickName + " <small> " + djMotto + "</small>");
            }
            if(djBio != ""){
            	$('#bio').append(djBio);
            }
            
            
        });
    }
	
	getCurrentUsersProfile();
});

