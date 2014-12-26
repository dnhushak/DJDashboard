$(document).ready(function(){
	$('#login-error').hide();

	
	$("#login").on('click', function(evt){
		if($('#user-name').val() == ''){
    		$('#login-error').html("User name is required");
    		$('#login-error').show();
    		$('#password').val('');
    		return;
		}
		if($('#password').val() == ''){
    		$('#login-error').html("Password is required");
    		$('#login-error').show();
    		$('#password').val('');
    		return;
		}
		$.ajax({
	            url: '../php/login.php',
	            type: 'POST',
	            data: {'user' : $('#user-name').val() , 'pass' : $('#password').val()},
	        }).done(function(data){
	        	try{
	        		var error = JSON.parse(data);
	        		$('#login-error').html(error['error']);
	        		$('#login-error').show();
	        		$('#password').val('');
	        		return;
	        	}catch(e){
	        	}	    		
	        	window.location.replace("./djdashboard.php");
		});
        evt.stopPropagation();
        evt.preventDefault();
	});
	$(document).keypress(function(e) {
	    if(e.which == 13) {
	        $('#login').trigger('click');
	    }
	});
});