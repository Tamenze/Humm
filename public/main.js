$(document).ready(function(){ 

var div = document.getElementById(".newHumm");



// function addNewHumm(){
// 	var newHummText=$("#newHumm").val();

// 	var newHumm=
// 	"<div class = "tweet">" + "<div class = "content">" + 
// 	// "<span>":user_id</span> + 
// 	"<p class = "Humm-text">" + newHummText + 
// 	"</p>" + 
// 	"</div></div>";

// 	return newHumm;  
// }

$('.button').on('click', function () {
    console.log("hre");
    $('#posty').prepend(div);
    });

});