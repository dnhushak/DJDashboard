$(document).ready(function(){
	$('#login-error').hide();

	$("#login").on('click', function(){
		$.ajax({
	            url: '../php/scripts/login.php',
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
	})
});