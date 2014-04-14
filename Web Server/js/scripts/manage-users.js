$(document).ready(function(){

	var LoadUserTypes = function(){
		$.ajax({
			url : '../php/scripts/getAllUserTypes.php',
			type : 'POST',
		}).done(function(data){
			var types;
			try{
				types = JSON.parse(data);
			}catch(e){
				console.log(e);
				return;
			}
			for(var i = 0; i < types.length; i++){
				$("#type-input").append('<option value="' + types[i]['UserTypeID'] + 
					'">' + types[i]['UserTypeName'] + '</option>')
			}
		});
	}

	$('#save-user').on('click', function(){
		var userName = $("#user-input").val();
		var email = $("#email-input").val();
		var firstName = $("#first-name-input").val();
		var lastName = $("#last-name-input").val();
		var typeID = $("#type-input").val();
		if(userName == "" || email == "" || firstName == "" || lastName == ""){
			$('.input-error').text('Please complete all fields.')
			$('.input-error').show();
		}else{
			$.ajax({
				url : '../php/scripts/addUser.php',
				data: {'user' : userName, 
						'email' : email,
						'first': firstName,
						'last': lastName,
						'type': typeID},
				type : 'POST',
			}).done(function(data) {
				try{
					var error = JSON.parse(data)["Error"];
					if(error == 2){
						$('.input-error').text('User name was already taken');
						$('.input-error').show();
					}else{
						$('#create-user').modal('hide');
					}
				}catch(e){
					console.log(data);
					return;
				}
			});
		}
	});

	$('.input-error').hide();
	LoadUserTypes();

});