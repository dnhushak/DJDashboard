// Array that all the reader info is temporarily held in, to prevent excessive db connections
var readerArr = {};

// Array that all reader typers are held in
var readerTypeArr = {};

// The currently "Active" reader
var activeID;

// Placeholder variable to show or not show hidden readers
var activeOnly = 1;

// Placeholder variables to store sorting information
var curSort = 'readerTitle';
var curAsc = 1;
var lastButton = '.header-title';
var lastButtonText = 'Title';

// Current page of readers
var curPage = 1;
// Number of readers to display per page
var numPerPage = 5;

/**
 * Todo List:
 * Reader type selections 
 * Privileges
 */

// Begins by getting all of the readers
function getReaderTypes(){
	$.ajax({
	    type : "POST",
	    data : {
		    'command' : 'getAllReaderTypes'
	    },
	    url : "../php/execute.php"
	}).done(function(data){
		try {
			// Parses the returned JSON object into a js array
			readerTypes = JSON.parse(data);
		} catch (e) {
			console.log(data);
			return;
		}
		
		// Runs through all of the reader types
		for (var i = 0; i < readerTypes.length; i++) {
			// Assigns the reader types to an array, indexable by the
			// reader Type ID
			var id = readerTypes[i]['id'];
			readerTypeArr[id] = {};
			readerTypeArr[id] = readerTypes[i];
			readerTypeArr[id].view = 1;
		}
		displayReaderTypes();
	});
};

// Begins by getting all of the readers
function displayReaderTypes(){
	
	for (id in readerTypeArr) {
		// Add each reader type to the dropdown menu in the main
		// window
		var html = '<li><a href=#>' + readerTypeArr[id]['name'] + '<\a><\li>';
		
		// And the options in the modal window
		var htmlSelect = '<option value="' + readerTypeArr[id]['id'] + '">'
		        + readerTypeArr[id]['name'] + '</option>';
		$('.readerTypes').append(html);
		$('.reader-select').append(htmlSelect);
	}
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
		displayReaders(curPage);
	});
};

/**
 * Gets the index of the reader based on its id
 */
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

function sortReaderButton(index, button, buttonText){
	if (index == curSort) {
		if (curAsc == 0) {
			curAsc = 1;
		} else {
			curAsc = 0;
		}
	} else {
		curAsc = 1;
		$(lastButton).html('');
		$(lastButton).append(lastButtonText);
	}
	$(button).html('');
	if (curAsc == 1) {
		$(button)
		        .append(
		                buttonText
		                        + ' <span class="glyphicon glyphicon-triangle-bottom"></span>');
	} else {
		$(button)
		        .append(
		                buttonText
		                        + ' <span class="glyphicon glyphicon-triangle-top"></span>');
	}
	lastButton = button;
	lastButtonText = buttonText;
	curSort = index;
	sortReaderColumn(curSort, curAsc);
	displayReaders(curPage);
}

function sortReaderColumn(index, asc){
	curAsc = asc;
	curSort = index;
	sortArrayByIndex(readerArr, curSort, curAsc);
}

function changePerPage(perPage){
	
	$('.button-per-page').html('');
	$('.button-per-page').append(
	        perPage + ' Per Page<span class="caret"></span>');
	numPerPage = perPage;
	displayReaders(1);
}

/**
 * Displays all of the readers in the readerArr variable This is separated out
 * from the getReaders to allow for sorting, reorganization, etc.
 */
function displayReaders(page){
	// Empties out the readers div
	$('.readers').html('');
	// Iterates through every reader
	// Starts at the beginning of each page, based on what the number per page
	// is and the current page
	curPage = page;
	var start = (numPerPage * (curPage - 1));
	var end = ((numPerPage * curPage));
	var j = 0;
	for (var i = 0; i < readerArr.length; i++) {
		// console.log(i);
		if ((readerArr[i].isActive == "1") || (activeOnly == 0)) {
			// Assemble the HTML Table of all of the readers
			// based on type
			if (j >= start && j < end) {
				// The starting HTML
				var html = '<tr ondblclick="editReaderButton('
				        + readerArr[i].id + ')"  ';
				
				// Dull the background if the item is inactive
				if (readerArr[i]['isActive'] == "0") {
					html += '" bgcolor="#AAA">';
				} else {
					html += '">';
				}
				;
				
				// Reader Title
				html += '<td>' + readerArr[i].readerTitle + ' </td>';
				
				// Reader Type
				html += '<td>' + readerArr[i].readerType + '</td>';
				
				// Number of reads remaining
				html += '<td>' + readerArr[i].readsRemaining + '</td>';
				
				// End date of reader
				html += '<td>' + readerArr[i].endDate + '</td>';
				
				// Edit button. The value="" is what is passed
				// on to
				// the edit function, which is the id of the
				// reader.
				html += '<td><button type="button" class="btn btn-primary btn-sm" id="editReaderButton" value="'
				        + readerArr[i].id
				        + '" onClick="editReaderButton('
				        + readerArr[i].id
				        + ')" value="'
				        + readerArr[i].id
				        + '">Edit</button></td>';
				
				// View button - to see what the text of the
				// reader
				// is
				html += '<td><button type="button" class="btn btn-primary btn-sm" id="viewReaderButton" value="'
				        + readerArr[i].id
				        + '" onClick="viewReaderButton('
				        + readerArr[i].id
				        + ')" value="'
				        + readerArr[i].id
				        + '">View</button></td>';
				
				html += '</td>';
				$('.readers').append(html);
			}
			j++;
		}
	}
	
	// If there are enough displayed to necessitate a page, display pagination
	// buttons
	if (j >= numPerPage) {
		
		// Add the table row and div
		html = '<tr><td colspan="6"><div class="btn-group" role="group" aria-label="...">';
		// Start the page counter at 0
		var buttonPage = 0;
		// Iterate through every set of pages
		for (var k = 0; k < j; k += numPerPage) {
			// Every page, up the page counter
			buttonPage++;
			// Display the button with the page embedded in the display readers
			// function
			html += '<button type="button" onClick="displayReaders('
			        + buttonPage + ')" class="btn ';
			
			// Check if this button represents the current page
			if (buttonPage == page) {
				// If it does, make the button blue
				html += 'btn-primary';
			} else {
				// If not, make it grey
				html += 'btn-default';
			}
			// Finish out the button
			html += '">' + buttonPage + '</button>';
		}
		// Finish out the div, table and row
		html += '</td></tr></div>';
		// Actually apply the html
		$('.readers').append(html);
	}
}

function viewReaderButton(id){
	activeID = id;
	// Acquire the index of the reader
	var index = getReaderByID(id);
	
	// Clear out the header and bodies
	$('.view-header').html('');
	$('.view-body').html('');
	$('.reader-text').html('');
	
	// Fill the header with the title of the reader
	$('.view-header').append(
	        '<h3>' + readerArr[index]['readerTitle'] + ' contents:</h3>');
	// Fill the text area with the reader's text, in big lettering
	$('.reader-text').append(
	        "<big>" + readerArr[index]['readerText'] + "</big>");
	$('#view-text').modal('show');
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
 * Sorts a multidimensional array based on a given index
 * 
 * @param array
 *            The multidimensional array to be sorted
 * @param index
 *            The array's index to sort by
 * @param asc
 *            1 for ascending sort, 2 for descending
 */
function sortArrayByIndex(array, index, asc){
	array = array.sort(compare);
	if (asc == 0) {
		array.reverse();
	}
	
	// Compare function for the array sort
	function compare(a, b){
		// If the indices are exactly the same, return 0
		if (a[index] === b[index]) {
			return 0;
		} else {
			// Check if string
			if (typeof a[index] == "string") {
				// If string, compare them lexographically by cheating and
				// converting them to uppercase
				return (a[index].toUpperCase() < b[index].toUpperCase() ? -1
				        : 1);
			} else {
				// If not a string, compare them by simple comparison
				return (a[index] < b[index]) ? -1 : 1;
			}
		}
	}
	
}

/**
 * Needs organization id fix
 */
function saveReader(id){
	var index = getReaderByID(id);
	// If adding a reader (id=0), initialize the readerArr[] array
	if (id == 0) {
		readerArr[index] = [];
	}
	// Gather all of the information from the input form by inspecting its
	// .values
	readerArr[index].id = id;
	readerArr[index].readerText = document.getElementById('input-text').value;
	
	// Get the typeID from the dropdown menu
	readerArr[index].idType = document.getElementById('input-type').value;
	// Translate that ID to the type name, and fill it into the JS array
	readerArr[index].readerType = readerTypeArr[readerArr[index].idType].name;
	
	readerArr[index].idOrganization = document
	        .getElementById('input-organization').value;
	readerArr[index].readerTitle = document.getElementById('input-title').value;
	readerArr[index].readsRemaining = Number(document
	        .getElementById('input-remaining-reads').value);
	console.log(readerArr[index].readsRemaining);
	console.log(3);
	readerArr[index].startDate = document.getElementById('input-start').value;
	readerArr[index].endDate = document.getElementById('input-end').value;
	
	// Replace the checked true or false with 1 or 0
	readerArr[index]['isActive'] = document.getElementById('input-active').checked ? 1
	        : 0;
	
	// Update the reader by filling in all the information
	$.ajax({
	    type : "POST",
	    data : {
	        'command' : 'UpdateReader',
	        'id' : readerArr[index]['id'],
	        'idtype' : readerArr[index]['idType'],
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
		// Reload page with local js info, doesn't need a new SQL call
		sortReaderColumn(curSort, curAsc);
		displayReaders(curPage);
	});
};

function loaddata(id){
	activeID = id;
	// getReaderTypes();
	var index = getReaderByID(id);
	
	// Empty out all of the fields
	$('.add-update-header').html('');
	$('.edit-footer').html('');
	document.getElementById('input-title').value = "";
	document.getElementById('input-type').value = "";
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
		document.getElementById('input-type').value = readerArr[index]['idType'];
		document.getElementById('input-organization').value = readerArr[index]['organization'];
		document.getElementById('input-remaining-reads').value = readerArr[index]['readsRemaining'];
		document.getElementById('input-start').value = readerArr[index]['startDate'];
		document.getElementById('input-end').value = readerArr[index]['endDate'];
		document.getElementById('input-active').checked = readerArr[index]['isActive'];
		
		// Generate a duplicate, save, and cancel button
		$('.edit-footer')
		        .append(
		                '<button type="button" class="btn btn-success close-load-modal" id="duplicateButton" onClick="saveReader(0)" data-dismiss="modal">Duplicate</button>'
		                        + '<button type="button" class="btn btn-danger close-load-modal"id="saveButton" onClick="saveReader(activeID)" data-dismiss="modal">Save</button>'
		                        + ' <button type="button" class="btn btn-warning close-load-modal" data-dismiss="modal">Cancel</button>');
		
	} else {
		// If no existing reader, change title to "Add New Reader"
		$('.add-update-header').append('<h3>Add New Reader</h3>');
		
		// Generate a save and cancel button
		$('.edit-footer')
		        .append(
		                '<button type="button" class="btn btn-danger close-load-modal"id="saveButton" onClick="saveReader(activeID)" data-dismiss="modal">Save</button>'
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
	displayReaders(curPage);
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
