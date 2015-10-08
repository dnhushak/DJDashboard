var readerArr = {};
var readerTypeArr = {};
var activeID;

$('document').ready(function() {
	
	// Begins by getting all of the readers
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
				// Parses the returned JSON object into a js array
				readerTypes = JSON.parse(data);
			}
			catch(e){
				console.log(data);
				return;
			}
	
			$('.readerTypes').html('');
			for (var i = 0; i< readerTypes.length; i++){
				
				var id = readerTypes[i]['id'];
				readerTypeArr[id] = {};
				readerTypeArr[id] = readerTypes[i];
				
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
			
			// Empties out the readers div
			$('.readers').html('');

			// todo: put in pagination buttons for > 25-30 readers
			// For each reader grabbed, parse out 
			for (var i = 0; i < readers.length; i++) {

				var id = readers[i]['id'];
				var title = readers[i]['readerTitle'];
				var readsRemaining = readers[i]['readsRemaining'];
				var organization = readers[i]['organization'];
				var killDate = readers[i]['endDate'];
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
				
				// End date of reader
				psaHTML += '<td>' + killDate + '</td>';
				
				// Edit button. The value="" is what is passed on to the edit function, which is the id of the reader.
				psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="editReaderButton" value="'+ id +'" onClick="editReaderButton(this.id)" value="'
						+ id + '">Edit</button></td>';
				
				// View button - to see what the text of the reader is
				psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="viewReaderButton" value="'+ id +'" onClick="viewReaderButton(this.id)" value="'
				+ id + '">View</button></td>';
				
				psaHTML += '</td>';
				$('.readers').append(psaHTML);

			}
		});
	};
	$(document).on('click', '#addButton', function(){
		loaddata(0);
	});
	$(document).on('click', '#editReaderButton', function(evt){
        editReaderButton($(this).val());
        evt.stopPropagation();
        evt.preventDefault();
    });
	
	$(document).on('click', '#viewReaderButton', function(evt){
        viewButton($(this).val());
        evt.stopPropagation();
        evt.preventDefault();
    });
	
	$(document).on('click', '#saveButton', function(evt){
		addReader(activeID); //Save this one
		evt.stopPropagation();
        evt.preventDefault();
	});
	
	function viewButton(id) {
		activeID = id;
		$('.view-header').html('');
		$('.view-body').html('');
		$('#view-text').modal('show');
		$('.view-header').append(
				'<h3>' + readerArr[id]['readerTitle'] + ' contents:</h3>');
		$('.reader-text').html('');
		$('.reader-text').append(readerArr[id]['readerText']);
	};

	function editReaderButton(id) {
		// Load the data into the editor window and display it
		loaddata(id);
	};

	/**
	 * Needs fix
	 */
	function addReader(id){
		readerArr[id] = {};
		readerArr[id]['readerText'] = document.getElementById('input-text').value;
		readerArr[id]['organization'] = document.getElementById('input-organization').value;
		readerArr[id]['readerTitle'] = document.getElementById('input-title').value;
		readerArr[id]['readsRemaining'] = document.getElementById('input-remaining-reads').value;
		readerArr[id]['startDate'] = document.getElementById('input-start').value;
		readerArr[id]['endDate'] = document.getElementById('input-end').value;
		readerArr[id]['isActive'] = document.getElementById('input-active').value;
		$.ajax({
			type : "POST",
			data : {
				'command' : 'UpdateReader',
				'id' : readerArr[id]['id'],
				// FIX!
				'idtype' : 1,
				// FIX!
				'idorganization' : 1,
				'readerTitle' : readerArr[id]['readerTitle'],
				'readerText' : readerArr[id]['readerText'],
				'startDate' : readerArr[id]['startDate'],
				'endDate' : readerArr[id]['endDate'],
				'isActive' : readerArr[id]['isActive'],
				'readsRemaining' : readerArr[id]['readsRemaining'],
				'priority' : 1
			},
			url : "../php/execute.php"
		}).done(function(data) {
			try {
				readers = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}
//			console.log(readers);
		});
//		this.getreaders(); //Reload page
	};

	function loaddata(clicked_id) {
		activeID = clicked_id;
		$('.add-update-header').html('');
		// $('.modal-body').html('');
		$('#add-update').modal('show');
		$('.add-update-header').append(
				'<h3>Add or Update Reader' + readerArr[clicked_id]['id'] + '</h3>');
		// $('.input-readerText').append(readerArr[clicked_id]['readerText']);
		document.getElementById('input-title').value = readerArr[clicked_id]['readerTitle'];
		document.getElementById('input-text').value = readerArr[clicked_id]['readerText'];
		document.getElementById('input-organization').value = readerArr[clicked_id]['organization'];
		document.getElementById('input-remaining-reads').value = readerArr[clicked_id]['readsRemaining'];
		document.getElementById('input-active').value = readerArr[clicked_id]['isActive'];
	};
	
	$('.viewSpecificException').on('click', function(evt) {
		console.log('clicked');
		evt.stopPropagation();
        evt.preventDefault();
	});

	//INITIAL LOAD
	getReaders();
	getReaderTypes();

});
