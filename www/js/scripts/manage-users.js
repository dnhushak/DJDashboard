$(document).ready(function(){

	var showInactive = false;

	var LoadSessionVars = function(){
		$.ajax({
			url : '../php/scripts/getSessionVars.php',
			type : 'GET',
		}).done(function(data){
			var sess;
			try{
				sess = JSON.parse(data);
			}catch(e){
				console.log(e);
				return;
			}
			if(sess['ppermissionedit'] == 0){
				$('#type-update').parent().hide();
			}
		});
	}

	var DeleteUser = function(userID){
		$.ajax({
			url : '../php/scripts/deleteUser.php',
			type : 'GET',
			data: {'UserID' : userID}
		}).done(function(data){
			LoadUsers();
		});
	}

	var UpdateUser = function(userID, firstName, lastName, email, type){
		$.ajax({
			url : '../php/scripts/updateUser.php',
			type : 'GET',
			data: {'UserID' : userID, 
				'FirstName' : firstName,
				'LastName' : lastName,
				'Email' : email,
				'TypeID' : type}
		}).done(function(data){
			$('.update-error').hide();
			$('#update-user').modal('hide');
			LoadUsers();

		});
	}

	var ReactivateUser = function(userID){
		$.ajax({
			url : '../php/scripts/reactivateUser.php',
			type : 'GET',
			data: {'UserID' : userID}
		}).done(function(data){
			LoadUsers();
		});
	}

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
				$("#type-update").append('<option value="' + types[i]['UserTypeID'] + 
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
			$('.users').html('');
			for(var i = 0; i < users.length; i++){
				if(users[i]["EndDate"] != "0000-00-00 00:00:00" && !showInactive){
					continue;
				}
				var userHTML = "";
				if(users[i]["EndDate"] == "0000-00-00 00:00:00"){
					userHTML = '<tr class="' + users[i]["UserID"] + '">';
				}else{
					userHTML = '<tr class="' + users[i]["UserID"] + ' inactive">';
				}
                userHTML += '<td class="username">' + users[i]["UserName"] + '</td>';
                userHTML += '<td class="firstname">' + users[i]["FirstName"] + '</td>';
                userHTML += '<td class="lastname">' + users[i]["LastName"] + '</td>';
                userHTML += '<td class="email">' + users[i]["email"] + '</td>';
                userHTML += '<td class="usertype ' + users[i]['UserTypeID'] + '">' + users[i]["UserTypeName"] + '</td>';
                userHTML += '<td><button data-toggle="modal" data-target="#update-user" type="button" class="btn btn-primary btn-sm update-user-btn"  value="' + users[i]["UserID"] + '">Update</button></td>';
                if(users[i]["EndDate"] == "0000-00-00 00:00:00"){
                	userHTML += '<td><button type="button" class="btn btn-danger btn-sm delete-user"  value="' + users[i]["UserID"] + '">Delete</button></td>';
				}else{
               		userHTML += '<td><button type="button" class="btn btn-danger btn-sm activate-user"  value="' + users[i]["UserID"] + '">Reactivate</button></td>';
				}
                userHTML += '</tr>';
                $('.users').append(userHTML);
			}
		});
	}

	$('#save-user').on('click', function(evt){
		var userName = $("#user-input").val();
		var email = $("#email-input").val();
		var firstName = $("#first-name-input").val();
		var lastName = $("#last-name-input").val();
		var typeID = $("#type-input").val();
		var pass = $("#password-input").val();
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
						'type': typeID,
						'pass': pass},
				type : 'POST',
			}).done(function(data) {
				try{
					var error = JSON.parse(data)["Error"];
					if(error == 2){
						$('.input-error').text('User name was already taken');
						$('.input-error').show();
					}else{
						$('.input-error').hide();
						$('#create-user').modal('hide');
						LoadUsers();
					}
				}catch(e){
					console.log(data);
					return;
				}
			});
		}
		evt.stopPropagation();
        evt.preventDefault();
	});

	$(".inactive-btn").on("click", function(evt){
		if(showInactive){
			showInactive = false;
			$(this).text("View Inactive Users");
		}else{
			showInactive = true;
			$(this).text("Hide Inactive Users");
		}
		LoadUsers();
		evt.stopPropagation();
        evt.preventDefault();
	});
	$(document).on('click', ".update-user-btn", function(evt){
		var lastName = $(this).parent().parent().find('.lastname').text();
		var email = $(this).parent().parent().find('.email').text();
		var firstName = $(this).parent().parent().find('.firstname').text();
		var userTypeID = $(this).parent().parent().find('.usertype').attr('class').match(/\d+/);
		var userID = $(this).val();

		$('#last-name-update').val(lastName);
		$('#first-name-update').val(firstName);
		$('#email-update').val(email);
		$('#type-update').val(userTypeID);
		$('#save-update-user').val(userID);
		evt.stopPropagation();
        evt.preventDefault();
	});
	$('#save-update-user').on('click', function(evt){
		var lastName = $('#last-name-update').val();
		var firstName = $('#first-name-update').val();
		var email = $('#email-update').val();
		var type = $('#type-update').val();
		var userID = $(this).val();

		if(lastName == '' || firstName == '' || email == ''){
			$('.update-error').show();
		}else{
			UpdateUser(userID, firstName, lastName, email, type);
		}
		evt.stopPropagation();
        evt.preventDefault();
	});
	$(document).on('click', '.delete-user' ,function(evt){
		var userID = $(this).val();
		DeleteUser(userID);
		evt.stopPropagation();
        evt.preventDefault();
	});
	$(document).on('click', '.activate-user' ,function(evt){
		var userID = $(this).val();
		ReactivateUser(userID);
		evt.stopPropagation();
        evt.preventDefault();
	});



	$('.input-error').hide();
	$('.update-error').hide();
	LoadUserTypes();
	LoadUsers();
	LoadSessionVars();
});