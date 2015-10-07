var arr;
var activeID;

$('document').ready(function() {
//
	var getReaders = function() {
		// Call getAllReaders proc to get the list of every reader
		$.ajax({
			type : "POST",
			data:{
				'command' : 'getAllReaders'
			},
			url : "../php/execute.php"
		})
		
		//After getting the data, parse out the JSON 
		.done(function(data) {
			var profile;
			try {
				readers = JSON.parse(data);
				console.log(readers);
			} catch (e) {
				console.log(data);
				return;
			}
			
			
			$('.readers').html('');

			// For each reader grabbed, parse out 
			for (var i = 0; i < readers.length; i++) {

				var id = readers[i]['id'];
				var title = readers[i]['readerTitle'];
				var readsRemaining = readers[i]['readsRemaining'];
				var organization = readers[i]['organization'];
				var usertitle = readers[i]['Usertitle'];
				var userID = readers[i]['UserID'];
				var lasttitle = readers[i]['Lasttitle'];
				var isActive = readers[i]['IsActive'];

				var psaHTML = '';
				if (isActive == "0") {
					psaHTML += '<tr class="' + id
							+ '" bgcolor="#D6D6D6">';
				} else {
					psaHTML += '<tr class="' + id + '">';
				}

				psaHTML += '<td>' + title + '</td>';
				psaHTML += '<td>' + organization + '</td>';
				psaHTML += '<td>' + readsRemaining + '</td>';
				psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="editButton" value="'+ i +'" onClick="editButton(this.id)" value="'
						+ readers.length + '">Edit</button></td>';
				psaHTML += '</td>';
				$('.readers').append(psaHTML);

				console.log(readers[1]['title']);
			}

			arr = readers;

			console.log(arr[1]['title']);

		});
	};
	$(document).on('click', '#addButton', function(){
		addPSA();
	});
	$(document).on('click', '#editButton', function(evt){
    	console.log('clicked');
//        editButton($(this).val());
    	editButton(1);
        evt.stopPropagation();
        evt.preventDefault();
    });
	$(document).on('click', '#saveButton', function(evt){
		savePSA(); //Save this one
		getreaders(); //Reload page
		evt.stopPropagation();
        evt.preventDefault();
	});

	function editButton(id) {
		// Call getAllReaders proc to get the list of every reader
		$.ajax({
			type : "POST",
			data:{
				'command' : 'getReaderByID',
				'id' : 1
			},
			url : "../php/execute.php"
		})
		
		.done(function(data) {
			try {
				readers = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}
		 arr[id]['title'] = readers['title']; 
		 arr[id]['readerText'] = readers['readerText'];
		 arr[id]['organization'] = readers['organization'];
		 arr[id]['readsRemaining']=readers['readsRemaining'];
		loaddata(id);
		//ajax complete, load the data
		});
	}

	function addPSA(){
		activeID = arr.length;
		arr[activeID] = new Array();
		arr[activeID]['id'] = "0"; //Database will check for 0
		arr[activeID]['title'] = "";
		arr[activeID]['CreateDate'] = "";
		arr[activeID]['readsRemaining'] = "";
		arr[activeID]['MaxreadsRemaining'] = "";
		arr[activeID]['organization'] = "";
		arr[activeID]['readerText'] = "";
		arr[activeID]['IsActive'] = "0";
		loaddata(activeID);
	}

	function savePSA(){
		arr[activeID]['readerText'] = document.getElementById('input-readerText').value;
		arr[activeID]['organization'] = document.getElementById('input-organization').value;
		arr[activeID]['title'] = document.getElementById('input-title').value;
		var playStr = document.getElementById('input-plays').value;
		var slashIndex = playStr.indexOf('/');
		arr[activeID]['readsRemaining'] = playStr.substring(0, slashIndex - 1);
		arr[activeID]['MaxreadsRemaining']  = playStr.substring(slashIndex + 1, playStr.length);
		console.log(arr[activeID]);
		$.ajax({
			type : "GET",
			data : {
				'id' : arr[activeID]['id'],
				'readerText' : arr[activeID]['readerText'],
				'title' : arr[activeID]['title'],
				'organization' : arr[activeID]['organization'],
				'readsRemaining' : arr[activeID]['readsRemaining'],
				'MaxreadsRemaining' : arr[activeID]['MaxreadsRemaining'],
				'EndDate' : '2014-06-06',
			},
			url : "../php/scripts/updatePSA.php"
		}).done(function(data) {
			var profile;
			try {
				readers = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}
			console.log(readers);
		});
	}

	function loaddata(clicked_id) {
		activeID = clicked_id;
		$('.modal-header').html('');
		// $('.modal-body').html('');
		$('#load-modal').modal('show');
		$('.modal-header').append(
				'<h3>PSA ID ' + arr[clicked_id]['id'] + '</h3>');
		// $('.input-readerText').append(arr[clicked_id]['readerText']);
		document.getElementById('input-title').value = arr[clicked_id]['title'];
		document.getElementById('input-readerText').value = arr[clicked_id]['readerText'];
		document.getElementById('input-organization').value = arr[clicked_id]['organization'];
		document.getElementById('input-plays').value = arr[clicked_id]['readsRemaining'] + " / " + arr[clicked_id]['MaxreadsRemaining'];
	
	}
	
	$('.viewSpecificException').on('click', function(evt) {
		console.log('clicked');
		evt.stopPropagation();
        evt.preventDefault();
	});

	//INITIAL LOAD
	getReaders();

});
