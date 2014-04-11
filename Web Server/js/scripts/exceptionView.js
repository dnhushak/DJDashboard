$('document').ready(function(){
	

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
                excpHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + exceptions.length + '">View</button></td>';
                excpHTML += '</td>';
                $('.exceptions').append(excpHTML);
            }
            
            
            
        });
    }
	
	getExceptions();
});

