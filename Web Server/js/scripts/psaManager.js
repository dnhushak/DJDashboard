var arr;
var activeID;

$('document').ready(function() {

	var getExceptions = function() {
		$.ajax({
			type : "GET",
			url : "../php/scripts/getPSABasicInfo.php"
		})
		.done(function(data) {
			var profile;
			try {
				psas = JSON.parse(data);
				console.log(psas)
			} catch (e) {
				console.log(data);
				return;
			}
			$('.psas').html('');

			for (var i = 0; i < psas.length; i++) {

				var psaID = psas[i]['PSAID'];
				var name = psas[i]['Name'];
				var createDate = psas[i]['CreateDate'];
				var playCount = psas[i]['PlayCount'];
				var sponsor = psas[i]['Sponsor'];
				var userName = psas[i]['UserName'];
				var userID = psas[i]['UserID'];
				var lastName = psas[i]['LastName'];
				var isActive = psas[i]['IsActive'];

				var psaHTML = '';
				if (isActive == "0") {
					psaHTML += '<tr class="' + psaID
							+ '" bgcolor="#D6D6D6">';
				} else {
					psaHTML += '<tr class="' + psaID + '">';
				}

				psaHTML += '<td>' + psaID + '</td>';
				psaHTML += '<td>' + name + '</td>';
				psaHTML += '<td>' + sponsor + '</td>';
				psaHTML += '<td>' + userName + '</td>';
				psaHTML += '<td>' + playCount + '</td>';
				psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="editButton" value="'+i+'" onClick="editButton(this.id)" value="'
						+ psas.length + '">Edit</button></td>';
				psaHTML += '</td>';
				$('.psas').append(psaHTML);
			}

			arr = psas;

		});
	}
	
	$(document).on('click', '#editButton', function(){
    	console.log('cliked');
        editButton($(this).val());
    });

	function editButton(id) {
		$.ajax({
			type : "GET",
			data : {
				'psaid' : arr[id]['PSAID']
			},
			url : "../php/scripts/GetPSASpecificInfo.php"
		}).done(function(data) {
			var profile;
			try {
				psas = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}

			arr[id]['Message'] = psas['Message'];
			arr[id]['Name'] = psas['Name'];
			arr[id]['Sponsor'] = psas['Sponsor'];
			loaddata(id)
		});
		//ajax complete, load the data
	}

	function addPSA(){
		activeID = arr.length;
		arr[activeID] = new Array();
		arr[activeID]['PSAID'] = "0"; //Database will check for 0
		arr[activeID]['Name'] = "";
		arr[activeID]['CreateDate'] = "";
		arr[activeID]['PlayCount'] = "";
		arr[activeID]['MaxPlayCount'] = "";
		arr[activeID]['Sponsor'] = "";
		arr[activeID]['Message'] = "";
		arr[activeID]['IsActive'] = "0";
		loaddata(activeID);
	}

	function savePSA(){
		arr[activeID]['Message'] = document.getElementById('input-message').value;
		arr[activeID]['Sponsor'] = document.getElementById('input-sponsor').value;
		arr[activeID]['Name'] = document.getElementById('input-name').value;
		var playStr = document.getElementById('input-plays').value;
		var slashIndex = playStr.indexOf('/');
		arr[activeID]['PlayCount'] = playStr.substring(0, slashIndex - 1);
		arr[activeID]['MaxPlayCount']  = playStr.substring(slashIndex + 1, playStr.length);
		console.log(arr[activeID]);
		$.ajax({
			type : "GET",
			data : {
				'psaid' : arr[activeID]['PSAID'],
				'Message' : arr[activeID]['Message'],
				'Name' : arr[activeID]['Name'],
				'Sponsor' : arr[activeID]['Sponsor'],
				'PlayCount' : arr[activeID]['PlayCount'],
				'MaxPlayCount' : arr[activeID]['MaxPlayCount'],
				'EndDate' : '2014-06-06',
			},
			url : "../php/scripts/updatePSA.php"
		}).done(function(data) {
			var profile;
			try {
				psas = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}
			console.log(psas);
		});
	}

	function loaddata(clicked_id) {
		activeID = clicked_id;
		$('.modal-header').html('');
		// $('.modal-body').html('');
		$('#load-modal').modal('show');
		$('.modal-header').append(
				'<h3>PSA ID ' + arr[clicked_id]['PSAID'] + '</h3>');
		// $('.input-message').append(arr[clicked_id]['Message']);
		document.getElementById('input-name').value = arr[clicked_id]['Name'];
		document.getElementById('input-message').value = arr[clicked_id]['Message'];
		document.getElementById('input-sponsor').value = arr[clicked_id]['Sponsor'];
		document.getElementById('input-plays').value = arr[clicked_id]['PlayCount'] + " / " + arr[clicked_id]['MaxPlayCount'];
	
	}
	
	$('.viewSpecificException').on('click', function() {
		console.log('clicked');
	});

	getExceptions();

});
