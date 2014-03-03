$(document).ready(function() {
	
	initialize = function(){
        
	$.ajax({
        url: '../php/scripts/viewExceptions.php',
        type: 'GET',
        success: function() {}
    }).done(function(data){
        var exceptions;
        try{
            exceptions = JSON.parse(data);
        }catch(e){
			PublishError(e);
            return;
        }
        if(exceptions['error'] == true){

        }else{

            for (var i = 0; i < exceptions.length; i++){
                var exceptionID = exceptions[i]['ExceptionLogID'];
                var message = exceptions[i]['Message'];
                var stacktrace = exceptions[i]['StackTrace'];
                var createDate = exceptions[i]['CreateDate'];
                var userID = songs[i]['UserID'];
                var userName = songs[i]['UserName'];
                var lastName = genres[parseInt(songs[i]['LastName'])];
                var firstName = genres[parseInt(songs[i]['FirstName'])];
                addException();
            }
        }
    })
	}
    
	function tableCreate(){
		var body=document.getElementsByTagName('body')[0];
		var tbl=document.createElement('table');
		tbl.style.width='100%';
		tbl.setAttribute('border','1');
		var tbdy=document.createElement('tbody');
		for(var i=0;i<3;i++){
		    var tr=document.createElement('tr');
		    for(var j=0;j<2;j++){
		        if(i==2 && j==1){
		                break
		                 } else {
		        var td=document.createElement('td');
		        td.appendChild(document.createTextNode('\u0020'))
		        i==1&&j==1?td.setAttribute('rowSpan','2'):null;
		        tr.appendChild(td)
		        }
		    }
		    tbdy.appendChild(tr);
		}
		tbl.appendChild(tbdy);
		body.appendChild(tbl)
		}
    
  //Error Publisher
	PublishError = function(e){
		var stack = e.stack;
		if((e.stack == "" || e.stack == undefined)){
			stack = "No stack available";
		}
		var ajaxCall = $.ajax({
			type: "GET",
			async:true,
			url: "../php/scripts/logException.php",
			data: {'Message' : e.message, 'StackTrace' : stack, 'userID' : '0'},
       		});
	}
	
	tableCreate();

}