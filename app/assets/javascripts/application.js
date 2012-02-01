// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
	
// Collapsible tables in Assignments section
	$('.assignTable').hide();
	$('.assignTitle').click(function(){
		$(this).toggleClass('assignTitleOpen');
		$(this).next('.assignTable').slideToggle();
	});
	
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