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
	// Call getAllReaders, basing whether or not to grab only active readers or
	// all readers on the activeOnly variable
	$
	        .ajax({
	            type : "POST",
	            data : {
	                'command' : 'getAllReaders',
	                'activeOnly' : activeOnly
	            },
	            url : "../php/execute.php"
	        })
	        
	        // After getting the data, parse out the JSON
	        .done(
	                function(data){
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
			                var type = readers[i]['readerType'];
			                var killDate = readers[i]['endDate'];
			                var isActive = readers[i]['isActive'];
			                
			                // Dump the reader readerArrays into the global
			                // readerArray, associated by id
			                readerArr[id] = [];
			                readerArr[id] = readers[i];
			                
			                // Assemble the HTML Table of all of the readers
			                // based on type
			                
			                // The starting HTML, blocking out user selection so
			                // double click doesn't look as awkward
			                var psaHTML = '<tr ondblclick="editReaderButton('
			                        + id + ')" class="noselect ' + id;
			                
			                // Dull the background if the item is inactive
			                if (isActive == "0") {
				                psaHTML += '" bgcolor="#AAA">';
			                } else {
				                psaHTML += '">';
			                }
			                ;
			                
			                // Reader Title
			                psaHTML += '<td>' + title + '</td>';
			                
			                // Reader Organization
			                psaHTML += '<td>' + type + '</td>';
			                
			                // Number of reads remaining
			                psaHTML += '<td>' + readsRemaining + '</td>';
			                
			                // End date of reader
			                psaHTML += '<td>' + killDate + '</td>';
			                
			                // Edit button. The value="" is what is passed
			                // on to
			                // the edit function, which is the id of the
			                // reader.
			                psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="editReaderButton" value="'
			                        + id
			                        + '" onClick="editReaderButton('
			                        + id
			                        + ')" value="'
			                        + id
			                        + '">Edit</button></td>';
			                
			                // View button - to see what the text of the
			                // reader
			                // is
			                psaHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="viewReaderButton" value="'
			                        + id
			                        + '" onClick="viewReaderButton('
			                        + id
			                        + ')" value="'
			                        + id
			                        + '">View</button></td>';
			                
			                psaHTML += '</td>';
			                $('.readers').append(psaHTML);
			                
		                }
	                });
};

function viewReaderButton(id){
	activeID = id;
	$('.view-header').html('');
	$('.view-body').html('');
	$('#view-text').modal('show');
	$('.view-header').append(
	        '<h3>' + readerArr[id]['readerTitle'] + ' contents:</h3>');
	$('.reader-text').html('');
	$('.reader-text').append("<big>" + readerArr[id]['readerText'] + "</big>");
};

function editReaderButton(id){
	// Load the data into the editor window and display it
	loaddata(id);
};

function addReaderButton(){
	// Open the editor window with empty data
	loaddata(0);
};

/**
 * Needs fix
 */
function addReader(id){
	// If adding a reader (id=0), initialize the readerArr[] array
	if (id == 0) {
		readerArr[id] = [];
	}
	// Gather all of the information from the input form by inspecting its
	// .values
	readerArr[id]['id'] = id;
	readerArr[id]['readerText'] = document.getElementById('input-text').value;
	readerArr[id]['readerType'] = document.getElementById('input-type').value;
	readerArr[id]['organization'] = document
	        .getElementById('input-organization').value;
	readerArr[id]['readerTitle'] = document.getElementById('input-title').value;
	readerArr[id]['readsRemaining'] = document
	        .getElementById('input-remaining-reads').value;
	readerArr[id]['startDate'] = document.getElementById('input-start').value;
	readerArr[id]['endDate'] = document.getElementById('input-end').value;
	// Replace the checked true or false with 1 or 0
	readerArr[id]['isActive'] = document.getElementById('input-active').checked ? 1
	        : 0;
	$.ajax({
	    type : "POST",
	    data : {
	        'command' : 'UpdateReader',
	        'id' : readerArr[id]['id'],
	        // FIX!
	        'idtype' : readerArr[id]['readerType'],
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
	}).done(function(data){
		getReaders(); // Reload page
	});
};

function loaddata(id){
	activeID = id;
	getReaderTypes();
	$('.add-update-header').html('');
	$('#add-update').modal('show');
	if (id != 0) {
		$('.add-update-header').append(
		        '<h3>Update ' + readerArr[id]['readerTitle'] + '</h3>');
		document.getElementById('input-title').value = readerArr[id]['readerTitle'];
		document.getElementById('input-text').value = readerArr[id]['readerText'];
		document.getElementById('input-organization').value = readerArr[id]['organization'];
		document.getElementById('input-remaining-reads').value = readerArr[id]['readsRemaining'];
		document.getElementById('input-start').value = readerArr[id]['startDate'];
		document.getElementById('input-end').value = readerArr[id]['endDate'];
		document.getElementById('input-active').checked = readerArr[id]['isActive'];
		
		$('.edit-footer').html('');
		$('.edit-footer')
		        .append(
		                '<button type="button" class="btn btn-success close-load-modal" id="duplicateButton" onClick="addReader(0)" data-dismiss="modal">Duplicate</button>'
		                        + '<button type="button" class="btn btn-danger close-load-modal"id="saveButton" onClick="addReader(activeID)" data-dismiss="modal">Save</button>'
		                        + ' <button type="button" class="btn btn-warning close-load-modal" data-dismiss="modal">Cancel</button>');
		
	} else {
		$('.edit-footer')
		        .append(
		                '<button type="button" class="btn btn-danger close-load-modal"id="saveButton" onClick="addReader(activeID)" data-dismiss="modal">Save</button>'
		                        + ' <button type="button" class="btn btn-warning close-load-modal" data-dismiss="modal">Cancel</button>');
		
		$('.add-update-header').append('<h3>Add New Reader</h3>');
		document.getElementById('input-active').checked = 1;
	}
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
	getReaders();
}

$('.viewSpecificException').on('click', function(evt){
	evt.stopPropagation();
	evt.preventDefault();
});

$('document').ready(function(){
	// INITIAL LOAD
	getReaders();
	getReaderTypes();
	
});
