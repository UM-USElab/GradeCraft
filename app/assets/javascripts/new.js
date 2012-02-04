$(document).ready(function(){
	
// Collapsible tables in Assignments section
	$('.collapsible').hide();

	$('.assignTitle').click(function(){
		$(this).toggleClass('assignTitleOpen');
		$(this).next('.collapsible').slideToggle();
	});

// Random PSA tip
	$("#psaBox p").hide();
	var psas = $("#psaBox p").get().sort(function(){ 
            return Math.round(Math.random())-0.5; //so we get the right +/- combo
           });
    var firstpsa = psas.slice(1,2);
	$(firstpsa).show();
	
// Progress bars to student dashboard
/*
	$('#scoreTotal').hide();
	$('#userBarTotal').hide();
	$('#showPossiblePts').hide();
*/	
	// ***Change this from hard-coded value when 'possible points' function is written 
	var availPoints = 300000;
	
	var currentUserScore = $('#userScoreNum').html();
	var totalInProgress = (currentUserScore/availPoints)*100;
	var totalFull = (currentUserScore/1245000)*100;
/*	
	$('#userBarInProgress').progressbar({
		value:totalInProgress
	});
*/	
	$('#userBarTotal').progressbar({
		value:totalFull
	});
/*	
	$('#scoreToggle').click(function(){
		$("#userScoreSection .toggle").toggle();
	});
*/	
});