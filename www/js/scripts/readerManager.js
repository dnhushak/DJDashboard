var readerArr = {};
var readerTypeArr = {};
var activeID;

$('document').ready(function() {
	var getReaderTypes = function(){
		$.ajax({
			type : "POST",
			data:{
				'command' : 'getAllReaderTypes'
			},
			url : "../php/execute.php"
		})
		.done(function(data){
			try{
				readerTypes = JSON.parse(data);
			}
			catch(e){
				console.log(data);
				return;
			}
			console.log(readerTypes[0]['description']);
	
			$('.readerTypes').html('');
			for (var i = 0; i< readerTypes.length; i++){
				
				var id = readerTypes[i]['id'];
				readerTypeArr[id] = {};
				readerTypeArr[id] = readerTypes[i];
				// Assemble the HTML Table of all of the readers based on type
				
				// Add each reader type to the dropdown menu
				var psaHTML = '<li><a href=#>' + readerTypeArr[id]['name'] + '<\a><\li>';
				$('.readerTypes').append(psaHTML);
			}
		});
	};
	
	
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
			try {
				readers = JSON.parse(data);
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
				var isActive = readers[i]['isActive'];

				// Dump the reader readerArrays into the global readerArray, associated by id
				readerArr[id] = {};
				readerArr[id] = readers[i];
				
				// Assemble the HTML Table of all of the readers based on type
				
				// The starting HTML
				var psaHTML = '';
				
				// Dull the background if the item is inactive
				if (isActive == "0") {
					psaHTML += '<tr class="' + id
							+ '" bgcolor="#D6D6D6">';
				} else {
					psaHTML += '<tr class="' + id + '">';
				}
				
				// Reader Title
				psaHTML += '<td>' + title + '</td>';
				
				// Reader Organization
				psaHTML += '<td>' + organization + '</td>';
				
				// Number of reads remaining
				psaHTML += '<td>' + readsRemaining + '</td>';
				
				// Edit button. The value="" is what is passed on to the edit function, which is the id of the reader.
				psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="editButton" value="'+ id +'" onClick="editButton(this.id)" value="'
						+ readers.length + '">Edit</button></td>';
				psaHTML += '</td>';
				$('.readers').append(psaHTML);

			}
		});
	};
	$(document).on('click', '#addButton', function(){
		addPSA();
	});
	$(document).on('click', '#editButton', function(evt){
        editButton($(this).val());
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
		// Load the data into the editor window and display it
		loaddata(id);
	}

	/**
	 * Needs fix
	 */
	function addPSA(){
		activeID = readerArr.length;
		readerArr[activeID] = new readerArray();
		readerArr[activeID]['id'] = "0"; //Database will check for 0
		readerArr[activeID]['title'] = "";
		readerArr[activeID]['CreateDate'] = "";
		readerArr[activeID]['readsRemaining'] = "";
		readerArr[activeID]['MaxreadsRemaining'] = "";
		readerArr[activeID]['organization'] = "";
		readerArr[activeID]['readerText'] = "";
		readerArr[activeID]['IsActive'] = "0";
		loaddata(activeID);
	}

	/**
	 * Needs fix
	 */
	function addReader(){
		readerArr[activeID]['readerText'] = document.getElementById('input-text').value;
		readerArr[activeID]['organization'] = document.getElementById('input-organization').value;
		readerArr[activeID]['title'] = document.getElementById('input-title').value;
		var playStr = document.getElementById('input-plays').value;
		var slashIndex = playStr.indexOf('/');
		readerArr[activeID]['readsRemaining'] = playStr.substring(0, slashIndex - 1);
		readerArr[activeID]['MaxreadsRemaining']  = playStr.substring(slashIndex + 1, playStr.length);
		console.log(readerArr[activeID]);
		$.ajax({
			type : "POST",
			data : {
				'id' : readerArr[activeID]['id'],
				'readerText' : readerArr[activeID]['readerText'],
				'title' : readerArr[activeID]['title'],
				'organization' : readerArr[activeID]['organization'],
				'readsRemaining' : readerArr[activeID]['readsRemaining'],
				'MaxreadsRemaining' : readerArr[activeID]['MaxreadsRemaining'],
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
				'<h3>Add or Update Reader' + readerArr[clicked_id]['id'] + '</h3>');
		// $('.input-readerText').append(readerArr[clicked_id]['readerText']);
		document.getElementById('input-title').value = readerArr[clicked_id]['readerTitle'];
		document.getElementById('input-text').value = readerArr[clicked_id]['readerText'];
		document.getElementById('input-organization').value = readerArr[clicked_id]['organization'];
		document.getElementById('input-plays').value = readerArr[clicked_id]['readsRemaining'] + " / " + readerArr[clicked_id]['MaxreadsRemaining'];
	
	}
	
	$('.viewSpecificException').on('click', function(evt) {
		console.log('clicked');
		evt.stopPropagation();
        evt.preventDefault();
	});

	//INITIAL LOAD
	getReaders();
	getReaderTypes();

});
