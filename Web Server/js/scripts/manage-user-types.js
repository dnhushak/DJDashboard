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
				var typeName = types[i]['UserTypeName'];
				var typeID = types[i]['UserTypeID'];
				var pLibView = types[i]['PLibraryView'];
				var pLibManage = types[i]['PLibraryManage'];
				var pPSAView = types[i]['PPSAView'];
				var pPSAManage = types[i]['PPSAManage'];
				var pGrantView = types[i]['PGrantView'];
				var pGrantEdit = types[i]['PGrantEdit'];
				var pManageUsers = types[i]['PManageUsers'];
				var pPlaylistEdit = types[i]['PPlaylistEdit'];
				var pPermissionEdit = types[i]['PPermissionEdit'];
				var pEditUserType = types[i]['PEditUserType'];
				var pOnAirSignOn = types[i]['OnAirSignOn'];
				var typeHTML = '<tr class="' + typeID + '">';
				typeHTML += '<td class="typeName">' + typeName + '</td>';
				if(pPlaylistEdit == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pOnAirSignOn == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pLibView == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pLibManage == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pPSAView == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pPSAManage == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pGrantView == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pGrantEdit == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pManageUsers == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pPermissionEdit == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				if(pEditUserType == 1){
					typeHTML += '<td class="typeName"><input type="checkbox" value="1" checked></td>';
				}else{
					typeHTML += '<td class="typeName"><input type="checkbox" value="0"></td>';
				}
				typeHTML += '<td><button type="button" class="btn btn-primary btn-sm save-user-type"  value="' + typeID + '">Save</button></td>'
				$('.types').append(typeHTML);
			}
		})
	};

	$('#save-user-type').on('click', function(){
		var name = $('#user-type-input').val();
		var pEditPlayList = $('#new-edit-playlists').prop( "checked" );
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
		
		if(name == ""){
			$(".input-error").show();
		}

	})

	LoadUserTypes();
	$('.input-error').hide();
});