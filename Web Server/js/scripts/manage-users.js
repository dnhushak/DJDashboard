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
	var LoadUsers = function(){
		$.ajax({
			url : '../php/scripts/getAllUsers.php',
			type : 'POST',
		}).done(function(data){
			var users;
			try{
				users = JSON.parse(data);
			}catch(e){
				console.log(e);
				return;
			}
			for(var i = 0; i < users.length; i++){
				var userHTML = '<tr class="' + users[i]["UserID"] + '">';
                userHTML += '<td>' + users[i]["UserName"] + '</td>';
                userHTML += '<td>' + users[i]["FirstName"] + '</td>';
                userHTML += '<td>' + users[i]["LastName"] + '</td>';
                userHTML += '<td>' + users[i]["email"] + '</td>';
                userHTML += '<td>' + users[i]["UserTypeName"] + '</td>';
                userHTML += '<td><button type="button" class="btn btn-danger btn-sm" id="mark-played" value="' + users[i]["UserID"] + '">Delete</button></td>';
                userHTML += '</td>';
                $('.users').append(userHTML);
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
	LoadUsers();

});