$(document).ready(function(){

	var UpdateUserType = function(typeID, libView, libEdit, psaView, psaEdit, grantView, grantEdit, manUsers, permEdit, utEdit, onAir, name, reviewMusic){
		$.ajax({
			url : '../php/scripts/updateUserType.php',
			type : 'GET',
			data : { 'TypeID' : typeID,
					 'LibraryView' : libView, 
					 'LibraryEdit' : libEdit,
					 'PSAView' : psaView,
					 'PSAEdit': psaEdit,
					 'GrantView' : grantView,
					 'GrantEdit' : grantEdit, 
					 'ManageUsers' : manUsers,
					 'PermissionEdit' : permEdit,
					 'UserTypeEdit' : utEdit, 
					 'OnAirSignOn' : onAir,
					 'ReviewMusic' : reviewMusic}
		}).done(function(data){
			try{
				$('#saved-name').html(name);
				$('.succesful-save').show();
			}catch(e){
				return;
			}
		})
	}

	var AddUserType = function(typeName, libView, libEdit, psaView, psaEdit, grantView, grantEdit, manUsers, permEdit, utEdit, onAir, reviewMusic){
		$.ajax({
			url : '../php/scripts/addUserType.php',
			type : 'GET',
			data : { 'TypeName' : typeName,
					 'LibraryView' : libView, 
					 'LibraryEdit' : libEdit,
					 'PSAView' : psaView,
					 'PSAEdit': psaEdit,
					 'GrantView' : grantView,
					 'GrantEdit' : grantEdit, 
					 'ManageUsers' : manUsers,
					 'PermissionEdit' : permEdit,
					 'UserTypeEdit' : utEdit, 
					 'OnAirSignOn' : onAir,
					 'ReviewMusic' : reviewMusic}
		}).done(function(data){
			try{
				console.log(data);
				var newType = JSON.parse(data);
				if(newType['Duplicate'] == 1){
					$('.duplicate-error').show();
				}else{
					LoadUserTypes();
					
					$('.types').html('');
					$('.input-error').hide();
					$('.duplicate-error').hide();
					$('#create-user-type').modal('hide');

					$('#user-type-input').val('');
					$('#new-on-air-sign-on').attr( "checked", false );
					$('#new-view-library').attr( "checked", false );
					$('#new-edit-library').attr( "checked", false );
					$('#new-view-psas').attr( "checked", false );
					$('#new-edit-psas').attr( "checked", false );
					$('#new-view-grants').attr( "checked", false );
					$('#new-edit-grants').attr( "checked", false );
					$('#new-manage-users').attr( "checked", false );
					$('#new-edit-permissions').attr( "checked", false );
					$('#new-edit-user-types').attr( "checked", false );
					$('#new-review-music').attr( "checked", false );
				}
			}catch(e){
				return;
			}
		})
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
				var typeName = types[i]['UserTypeName'];
				var typeID = types[i]['UserTypeID'];
				var pLibView = types[i]['PLibraryView'];
				var pLibManage = types[i]['PLibraryManage'];
				var pPSAView = types[i]['PPSAView'];
				var pPSAManage = types[i]['PPSAManage'];
				var pGrantView = types[i]['PGrantView'];
				var pGrantEdit = types[i]['PGrantEdit'];
				var pManageUsers = types[i]['PManageUsers'];
				var pPermissionEdit = types[i]['PPermissionEdit'];
				var pEditUserType = types[i]['PEditUserType'];
				var pOnAirSignOn = types[i]['OnAirSignOn'];
				var pReviewMusic = types[i]['ReviewMusic'];
				var typeHTML = '<tr class="' + typeID + '">';
				typeHTML += '<td class="type-name">' + typeName + '</td>';
				if(pOnAirSignOn == 1){
					typeHTML += '<td><input class="on-air-sign-on" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="on-air-sign-on" type="checkbox" value="0"></td>';
				}
				if(pLibView == 1){
					typeHTML += '<td><input class="library-view" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="library-view" type="checkbox" value="0"></td>';
				}
				if(pLibManage == 1){
					typeHTML += '<td><input class="library-manage" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="library-manage" type="checkbox" value="0"></td>';
				}
				if(pPSAView == 1){
					typeHTML += '<td><input class="psa-view" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="psa-view" type="checkbox" value="0"></td>';
				}
				if(pPSAManage == 1){
					typeHTML += '<td><input class="psa-edit" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="psa-edit" type="checkbox" value="0"></td>';
				}
				if(pGrantView == 1){
					typeHTML += '<td><input class="grant-view" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="grant-view" type="checkbox" value="0"></td>';
				}
				if(pGrantEdit == 1){
					typeHTML += '<td><input class="grant-edit" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="grant-edit" type="checkbox" value="0"></td>';
				}
				if(pManageUsers == 1){
					typeHTML += '<td><input class="manage-users" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="manage-users" type="checkbox" value="0"></td>';
				}
				if(pPermissionEdit == 1){
					typeHTML += '<td><input class="edit-permissions" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="edit-permissions" type="checkbox" value="0"></td>';
				}
				if(pEditUserType == 1){
					typeHTML += '<td><input class="edit-user-types" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="edit-user-types" type="checkbox" value="0"></td>';
				}
				if(pReviewMusic == 1){
					typeHTML += '<td><input class="review-music" type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td><input class="review-music" type="checkbox" value="0"></td>';
				}
				typeHTML += '<td><button type="button" class="btn btn-primary btn-sm update-user-type"  value="' + typeID + '">Save</button></td>'
				$('.types').append(typeHTML);
			}
		})
	};

	$('#save-user-type').on('click', function(){
		var name = $('#user-type-input').val();
		var pOnAirSignOn = $('#new-on-air-sign-on').prop( "checked" );
		var pViewLibrary = $('#new-view-library').prop( "checked" );
		var pEditLibrary = $('#new-edit-library').prop( "checked" );
		var pPSAView = $('#new-view-psas').prop( "checked" );
		var pPSAManage = $('#new-edit-psas').prop( "checked" );
		var pGrantView = $('#new-view-grants').prop( "checked" );
		var pGrantEdit = $('#new-edit-grants').prop( "checked" );
		var pManageUsers = $('#new-manage-users').prop( "checked" );
		var pPermissionEdit = $('#new-edit-permissions').prop( "checked" );
		var pEditUserType = $('#new-edit-user-types').prop( "checked" );
		var pReviewMusic = $('#new-review-music').prop( "checked" );
		
		if(name == ""){
			$(".input-error").show();
		}else{
			AddUserType(name, pViewLibrary, pEditLibrary, pPSAView, pPSAManage,
				pGrantView, pGrantEdit, pManageUsers, pPermissionEdit,
				pEditUserType, pOnAirSignOn, pReviewMusic);
		}

	})
	
	$(document).on('click', '.update-user-type', function(){
		var name = $(this).parent().parent().find('.type-name').text();
		var id = $(this).val();
		var pOnAirSignOn = $(this).parent().parent().find('.on-air-sign-on').prop( "checked" );
		var pViewLibrary = $(this).parent().parent().find('.library-view').prop( "checked" );
		var pEditLibrary = $(this).parent().parent().find('.library-manage').prop( "checked" );
		var pPSAView = $(this).parent().parent().find('.psa-view').prop( "checked" );
		var pPSAManage = $(this).parent().parent().find('.psa-edit').prop( "checked" );
		var pGrantView = $(this).parent().parent().find('.grant-view').prop( "checked" );
		var pGrantEdit = $(this).parent().parent().find('.grant-edit').prop( "checked" );
		var pManageUsers = $(this).parent().parent().find('.manage-users').prop( "checked" );
		var pPermissionEdit = $(this).parent().parent().find('.edit-permissions').prop( "checked" );
		var pEditUserType = $(this).parent().parent().find('.edit-user-types').prop( "checked" );
		var pReviewMusic = $(this).parent().parent().find('.review-music').prop( "checked" );

		UpdateUserType(id, pViewLibrary, pPSAView, pPSAManage,
		 		pGrantView, pGrantEdit, pManageUsers, pPermissionEdit,
		 		pEditUserType, pOnAirSignOn, name, pReviewMusic);
	});
	$('.close').on('click', function(evt){
		$('.succesful-save').hide();
		evt.stopPropagation();
		evt.preventDefault();
	});

	LoadUserTypes();
	$('.input-error').hide();
	$('.duplicate-error').hide();
	$('.succesful-save').hide();
});