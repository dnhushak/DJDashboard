var arr;

$('document').ready(function(){
    /**
     * Erases the list and gets errors
     */
    function getErrors(){	
    	$.ajax({
            type: "GET",
            url: "../php/scripts/viewErrors.php"
        }).done(function(data){
            var profile;
            try{
                exceptions = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            $('.exceptions').html('');

    		
            for(var i = 0; i < exceptions.length; i++){
            	
                var errorID = exceptions[i]['ErrorLogID'];
                var message = exceptions[i]['Message'];
                var stackTrace = exceptions[i]['StackTrace'];
                var userID = exceptions[i]['UserID'];
                var userName = exceptions[i]['UserName'];
                var firstName = exceptions[i]['FirstName'];
                var lastName = exceptions[i]['LastName'];
                var createDate = exceptions[i]['CreateDate'];
                
                var excpHTML = '<tr class="' + errorID + '">';
                
                excpHTML += '<td>' + errorID + '</td>';
                excpHTML += '<td>' + userName + '</td>';
                excpHTML += '<td>' + lastName + '</td>';
                excpHTML += '<td>' + message.substring(0, 40); + '</td>';
                excpHTML += '<td>' + createDate + '</td>';
                excpHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="'+ i +'" onClick="viewButton(this.id)" value="' + exceptions.length + '">View</button></td>';
                excpHTML += '</td>';
                $('.exceptions').append(excpHTML);
            }
            
            arr = exceptions;
            
        });
    }

    var getExceptions = function(){
        $.ajax({
            type: "GET",
            url: "../php/scripts/viewExceptions.php"
        }).done(function(data){
            var profile;
            try{
                exceptions = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            $('.exceptions').html('');

    		
            for(var i = 0; i < exceptions.length; i++){
            	
                var exceptionID = exceptions[i]['ExceptionLogID'];
                var message = exceptions[i]['Message'];
                var stackTrace = exceptions[i]['StackTrace'];
                var userID = exceptions[i]['UserID'];
                var userName = exceptions[i]['UserName'];
                var firstName = exceptions[i]['FirstName'];
                var lastName = exceptions[i]['LastName'];
                var createDate = exceptions[i]['CreateDate'];
                
                var excpHTML = '<tr class="' + exceptionID + '">';
                
                excpHTML += '<td>' + exceptionID + '</td>';
                excpHTML += '<td>' + userName + '</td>';
                excpHTML += '<td>' + lastName + '</td>';
                excpHTML += '<td>' + message.substring(0, 40); + '</td>';
                excpHTML += '<td>' + createDate + '</td>';
                excpHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="viewButton" value="' + i + '">View</button></td>';
                excpHTML += '</td>';
                $('.exceptions').append(excpHTML);
            }
            
            arr = exceptions;
            
        });
    }

    $(document).on('click', '#viewButton', function(){
        viewButton($(this).val());
    });
    
    $(document).on('click', '#ErrorButton', function(){
    	getErrors();
    });
    
    $(document).on('click', '#ExceptionButton', function(){
    	getExceptions();
    })
    
    function viewButton(clicked_id)
    {

    	$('.modal-header').html('');
    	$('.modal-body').html('');
        $('#load-modal').modal('show');
        $('.modal-header').append('<h3>ExceptionID ' + exceptions[clicked_id]['ExceptionLogID'] + '</h3>');
        $('.modal-body').append('<h4>User</h4><p>' + exceptions[clicked_id]['LastName'] + ', ' + exceptions[clicked_id]['FirstName']
        	+ '  [' + exceptions[clicked_id]['UserName'] + ']</p>');
        $('.modal-body').append('<h4>Message</h4><p>' + exceptions[clicked_id]['Message'] + '</p>');
        $('.modal-body').append('<h4>StackTrace</h4><p>' + exceptions[clicked_id]['StackTrace'] + '</p>');
    }
    $('.viewSpecificException').on('click', function(){
        console.log('clicked');
    });
    
    getExceptions();
});
