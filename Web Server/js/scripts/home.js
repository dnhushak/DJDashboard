/**
 * 
 */

$('document').ready(function(){
	console.log('doc ready');
	$.ajax({
        url: '../php/scripts/getDJs.php',
        type: 'GET',
        success: function(){}
    }).done(function(data){
        var initial;
        try{
            initial = JSON.parse(data);
        }catch(e){
            console.log('Error loading initial info');
            console.log(data);
            return;
        }
        var djHTML = "";
        for(var i = 0; i < initial.length; i++){
           djHTML += '<li id="'+initial[i]['UserID']+'">'+initial[i]['FirstName']+' '+initial[i]['LastName']+'</li>';
        }
        console.log(initial);
        $('.djList').html(djHTML);
    });
});