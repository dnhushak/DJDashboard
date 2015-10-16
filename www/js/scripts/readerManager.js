// Array that all the reader info is temporarily held in, to prevent excessive db connections
var readerArr = {};

// Array that all reader typers are held in
var readerTypeArr = {};

// The currently "Active" reader
var activeID;

// Placeholder variable to show or not show hidden readers
var activeOnly = 1;

// Begins by getting all of the readers
function getReaderTypes(){
	$.ajax({
	    type : "POST",
	    data : {
		    'command' : 'getAllReaderTypes'
	    },
	    url : "../php/execute.php"
	}).done(
	        function(data){
		        try {
			        // Parses the returned JSON object into a js array
			        readerTypes = JSON.parse(data);
		        } catch (e) {
			        console.log(data);
			        return;
		        }
		        
		        $('.reader-select').html('');
		        for (var i = 0; i < readerTypes.length; i++) {
			        
			        var id = readerTypes[i]['id'];
			        readerTypeArr[id] = {};
			        readerTypeArr[id] = readerTypes[i];
			        
			        // Add each reader type to the dropdown menu
			        var psaHTML = '<li><a href=#>' + readerTypeArr[id]['name']
			                + '<\a><\li>';
			        
			        var psaHTMLSelect = '<option value="'
			                + readerTypeArr[id]['id'] + '">'
			                + readerTypeArr[id]['name'] + '</option>';
			        $('.readerTypes').append(psaHTML);
			        $('.reader-select').append(psaHTMLSelect);
		        }
	        });
};

function getReaders(){
	readerArr = {};
	// Call getAllReaders, basing whether or not to grab only active readers or
	// all readers on the activeOnly variable
	$.ajax({
	    type : "POST",
	    data : {
		    'command' : 'getAllReaders'
	    },
	    url : "../php/execute.php"
	})
	// After getting the data, parse out the JSON into the readerArr
	.done(function(data){
		try {
			readerArr = JSON.parse(data);
		} catch (e) {
			console.log(data);
			return;
		}
		displayReaders();
	});
};

// Gets the index of the reader based on its id
function getReaderByID(id){
	// Iterates through the reader array
	for (var i = 0; i < readerArr.length; i++) {
		// If the id is correct, return the index
		if (readerArr[i].id == id) {
			return i;
		}
	}
	// If id not found, return the length (next index) of the array
	return readerArr.length;
}

function displayReaders(){
	// Empties out the readers div
	$('.readers').html('');
	// Iterates through every reader
	for (var i = 0; i < readerArr.length; i++) {
		if ((readerArr[i].isActive == "1") || (activeOnly == 0)) {
			// Assemble the HTML Table of all of the readers
			// based on type
			
			// The starting HTML, blocking out user selection so
			// double click doesn't look as awkward
			var psaHTML = '<tr ondblclick="editReaderButton(' + readerArr[i].id
			        + ')" class="noselect ' + readerArr[i].id;
			
			// Dull the background if the item is inactive
			if (readerArr[i]['isActive'] == "0") {
				psaHTML += '" bgcolor="#AAA">';
			} else {
				psaHTML += '">';
			}
			;
			
			// Reader Title
			psaHTML += '<td>' + readerArr[i].readerTitle + ' </td>';
			
			// Reader Type
			psaHTML += '<td>' + readerArr[i].readerType + '</td>';
			
			// Number of reads remaining
			psaHTML += '<td>' + readerArr[i].readsRemaining + '</td>';
			
			// End date of reader
			psaHTML += '<td>' + readerArr[i].endDate + '</td>';
			
			// Edit button. The value="" is what is passed
			// on to
			// the edit function, which is the id of the
			// reader.
			psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="editReaderButton" value="'
			        + readerArr[i].id
			        + '" onClick="editReaderButton('
			        + readerArr[i].id
			        + ')" value="'
			        + readerArr[i].id
			        + '">Edit</button></td>';
			
			// View button - to see what the text of the
			// reader
			// is
			psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="viewReaderButton" value="'
			        + readerArr[i].id
			        + '" onClick="viewReaderButton('
			        + readerArr[i].id
			        + ')" value="'
			        + readerArr[i].id
			        + '">View</button></td>';
			
			psaHTML += '</td>';
			$('.readers').append(psaHTML);
		}
	}
}

function viewReaderButton(id){
	activeID = id;
	// Acquire the index of the reader
	var index = getReaderByID(id);
	$('.view-header').html('');
	$('.view-body').html('');
	$('#view-text').modal('show');
	$('.view-header').append(
	        '<h3>' + readerArr[index]['readerTitle'] + ' contents:</h3>');
	$('.reader-text').html('');
	$('.reader-text').append(
	        "<big>" + readerArr[index]['readerText'] + "</big>");
};

function editReaderButton(id){
	// Load the data into the editor window and display it
	loaddata(id);
};
function clearReaders(){
	// Empties out the readers div
	$('.readers').html('');
}

function addReaderButton(){
	// Open the editor window with empty data
	loaddata(0);
};

/**
 * Needs fix
 */
function addReader(id){
	var index = getReaderByID(id);
	// If adding a reader (id=0), initialize the readerArr[] array
	if (id == 0) {
		readerArr[index] = [];
	}
	// Gather all of the information from the input form by inspecting its
	// .values
	readerArr[index]['id'] = id;
	readerArr[index]['readerText'] = document.getElementById('input-text').value;
	readerArr[index]['readerType'] = document.getElementById('input-type').value;
	readerArr[index]['organization'] = document
	        .getElementById('input-organization').value;
	readerArr[index]['readerTitle'] = document.getElementById('input-title').value;
	readerArr[index]['readsRemaining'] = document
	        .getElementById('input-remaining-reads').value;
	readerArr[index]['startDate'] = document.getElementById('input-start').value;
	readerArr[index]['endDate'] = document.getElementById('input-end').value;
	
	// Replace the checked true or false with 1 or 0
	readerArr[index]['isActive'] = document.getElementById('input-active').checked ? 1
	        : 0;
	
	// Update the reader by filling in all the information
	$.ajax({
	    type : "POST",
	    data : {
	        'command' : 'UpdateReader',
	        'id' : readerArr[index]['id'],
	        'idtype' : readerArr[index]['readerType'],
	        // FIX!
	        'idorganization' : 1,
	        'readerTitle' : readerArr[index]['readerTitle'],
	        'readerText' : readerArr[index]['readerText'],
	        'startDate' : readerArr[index]['startDate'],
	        'endDate' : readerArr[index]['endDate'],
	        'isActive' : readerArr[index]['isActive'],
	        'readsRemaining' : readerArr[index]['readsRemaining'],
	        'priority' : 1
	    },
	    url : "../php/execute.php"
	}).done(function(data){
		getReaders(); // Reload page
	});
};

function loaddata(id){
	activeID = id;
	getReaderTypes();
	var index = getReaderByID(id);
	
	// Empty out all of the fields
	$('.add-update-header').html('');
	$('.edit-footer').html('');
	document.getElementById('input-title').value = "";
	document.getElementById('input-type').value = 3;
	document.getElementById('input-text').value = "";
	document.getElementById('input-organization').value = "";
	document.getElementById('input-remaining-reads').value = "";
	document.getElementById('input-start').value = "";
	document.getElementById('input-end').value = "";
	document.getElementById('input-active').checked = "";
	
	// Check for existing reader
	if (id != 0) {
		// If yes, say "Update *readerTitle*"
		$('.add-update-header').append(
		        '<h3>Update ' + readerArr[index]['readerTitle'] + '</h3>');
		
		// Fill in all of the current information into the input fields
		document.getElementById('input-title').value = readerArr[index]['readerTitle'];
		document.getElementById('input-text').value = readerArr[index]['readerText'];
		// document.getElementById('input-type').value =
		// readerArr[index]['idType'];
		document.getElementById('input-organization').value = readerArr[index]['organization'];
		document.getElementById('input-remaining-reads').value = readerArr[index]['readsRemaining'];
		document.getElementById('input-start').value = readerArr[index]['startDate'];
		document.getElementById('input-end').value = readerArr[index]['endDate'];
		document.getElementById('input-active').checked = readerArr[index]['isActive'];
		
		// Generate a duplicate, save, and cancel button
		$('.edit-footer')
		        .append(
		                '<button type="button" class="btn btn-success close-load-modal" id="duplicateButton" onClick="addReader(0)" data-dismiss="modal">Duplicate</button>'
		                        + '<button type="button" class="btn btn-danger close-load-modal"id="saveButton" onClick="addReader(activeID)" data-dismiss="modal">Save</button>'
		                        + ' <button type="button" class="btn btn-warning close-load-modal" data-dismiss="modal">Cancel</button>');
		
	} else {
		// If no existing reader, change title to "Add New Reader"
		$('.add-update-header').append('<h3>Add New Reader</h3>');
		
		// Generate a save and cancel button
		$('.edit-footer')
		        .append(
		                '<button type="button" class="btn btn-danger close-load-modal"id="saveButton" onClick="addReader(activeID)" data-dismiss="modal">Save</button>'
		                        + ' <button type="button" class="btn btn-warning close-load-modal" data-dismiss="modal">Cancel</button>');
		
		// Set checked to 1 (default)
		document.getElementById('input-active').checked = 1;
	}
	// Show the dialogue
	$('#add-update').modal('show');
};

function viewHideInactive(){
	$('.view-inactive').html('');
	if (activeOnly == 1) {
		activeOnly = 0;
		$('.view-inactive').append("Hide Inactive");
	} else {
		activeOnly = 1;
		$('.view-inactive').append("View Inactive");
	}
	displayReaders();
}

$('.viewSpecificException').on('click', function(evt){
	evt.stopPropagation();
	evt.preventDefault();
});

$('document').ready(function(){
	// INITIAL LOAD
	getReaderTypes();
	getReaders();
});
