$(document).ready(function(){ 

$("#sam").click(function(){
	$("#sign_up_section").toggle();
});

window.onload = function changey(){
for (i=0;i<6;i++){ 
    x="live_post"+i; 
 document.getElementById(x).innerHTML="New thing";
}
};

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

// $("#chime").on('click', function () {
//     console.log("hre");
//     $('#posty').prepend(div);
//     });

});