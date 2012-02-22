$(document).ready(function(){

// hide items of class hidden-section
	$(".hidden-section").hide();
	
// set initial point values
	var attendancePts = 0;
	var rxnPts = 0;
	var blogPts = 0;
	var draftPts = 0;
	var sliderPts = 0;
	var totalPts;
	var gradePct = (totalPts/540000)*100				

// adds up total points
	function getTotalPts(){
		totalPts = attendancePts + rxnPts + blogPts + draftPts + sliderPts
	};

// adds points per class attended and reading reaction completed
	$(".class-checkbox").change(function(){
		attendancePts = ($("#classes-missed > input").filter(":checked").length)*5000;
		updateProgressBar();			
	});

// adds points for blog posts
	$("#blogging-yes").click(function(){
		$("#weekly-blogging").slideDown('fast');
		blogPts = 5000;
		updateProgressBar();
	});

	$("#total-blogposts").change(function(){
		blogPts = ($(this).val())*5000;
		console.log(blogPts);
		updateProgressBar();
	})

	$("#blogging-no").click(function(){
		$("#weekly-blogging").slideUp();
		blogPts = 0;
		updateProgressBar();
	});

// set points based on final draft completion
	$("#final-draft-yes").click(function(){
		draftPts = 5000;
		updateProgressBar();							
	});
	$("#final-draft-no").click(function(){
		draftPts = 0;
		updateProgressBar();				
	});

// create sliders for training missions and boss battles
	$( "#game-selection-slider" ).slider({
		value:20000,
		min: 20000,
		max: 40000,
		step: 2000,
		slide: function( event, ui ) {
			$("#game-selection-skill" ).val( ui.value-20000 );
			$("#game-selection-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();				
		}

	});
	$( "#game-selection-amount" ).val( $( "#game-selection-slider" ).slider( "value" ) );

	$( "#final-project-proposal-slider" ).slider({
		value:20000,
		min: 20000,
		max: 40000,
		step: 2000,
		slide: function( event, ui ) {
			$("#final-project-proposal-skill" ).val( ui.value-20000 );
			$("#final-project-proposal-total" ).val( ui.value );				
		},
		change: function( event, ui ) {
			updateProgressBar();				
		}
	});
	$( "#final-project-proposal-amount" ).val( $( "#final-project-proposal-slider" ).slider( "value" ) );

	$( "#final-presentation-slider" ).slider({
		value:20000,
		min: 20000,
		max: 40000,
		step: 2000,
		slide: function( event, ui ) {
			$("#final-presentation-skill" ).val( ui.value-20000 );
			$("#final-presentation-total" ).val( ui.value );				
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#final-presentation-amount" ).val( $( "#final-presentation-slider" ).slider( "value" ) );

	$( "#showandtell-slider" ).slider({
		value:80000,
		min: 80000,
		max: 120000,
		step: 1000,
		slide: function( event, ui ) {
			$("#showandtell-skill" ).val( ui.value-80000 );
			$("#showandtell-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#showandtell-amount" ).val( $( "#showandtell-slider" ).slider( "value" ) );

	$( "#final-project-slider" ).slider({
		value:80000,
		min: 80000,
		max: 120000,
		step: 1000,
		slide: function( event, ui ) {
			$("#final-project-skill" ).val( ui.value-80000 );
			$("#final-project-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#final-project-amount" ).val( $( "#final-project-slider" ).slider( "value" ) );

	$( "#gameplay-reflection-slider" ).slider({
		value:80000,
		min: 80000,
		max: 120000,
		step: 1000,
		slide: function( event, ui ) {
			$("#gameplay-reflection-skill" ).val( ui.value-80000 );
			$("#gameplay-reflection-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#gameplay-reflection-amount" ).val( $( "#gameplay-reflection-slider" ).slider( "value" ) );

// set slider values
	var gameplaySelectionPts = 0;
	var finalProposalPts = 0;
	var finalPresentationPts = 0;
	var showTellPts = 0;
	var finalProjectPts = 0;
	var gameReflectionPts = 0;

// get slider point values
	function getSliderPts(){
		gameplaySelectionPts = $( "#game-selection-slider" ).slider( "option", "value" );
		finalProposalPts = $( "#final-project-proposal-slider" ).slider( "option", "value" );
		finalPresentationPts = $( "#final-presentation-slider" ).slider( "option", "value" );
		showTellPts = $( "#showandtell-slider" ).slider( "option", "value" );
		finalProjectPts = $( "#final-project-slider" ).slider( "option", "value" );
		gameReflectionPts = $( "#gameplay-reflection-slider" ).slider( "option", "value" );

		sliderPts = gameplaySelectionPts + finalProposalPts + finalPresentationPts + showTellPts + finalProjectPts + gameReflectionPts;
		getGradePct();
	};

// get percentage
	function getGradePct(){
		getTotalPts();
		gradePct = (totalPts/540000)*100
	};
	
// update the progress bar
	function updateProgressBar(){
		getSliderPts();
		getGradePct();
		$("#progressbar").progressbar({
			value: gradePct
		});
		$("#expected-grade").html(totalPts);


// update the points --> letter grade table
		$("#grade-table tr").removeClass("grade-selected");

		if (totalPts < 420000){

		}
		else if (totalPts < 440000){
			$("#dplusgrade").addClass("grade-selected");
		}
		else if(totalPts < 460000){
					$("#cminusgrade").addClass("grade-selected");
				}
		else if(totalPts < 470000){
			$("#cgrade").addClass("grade-selected");
		}
		else if(totalPts < 480000){
			$("#cplusgrade").addClass("grade-selected");
		}
		else if(totalPts < 500000){
			$("#bminusgrade").addClass("grade-selected");
		}
		else if(totalPts < 506000){
			$("#bgrade").addClass("grade-selected");
		}
		else if(totalPts < 513000){
			$("#bplusgrade").addClass("grade-selected");
		}
		else if(totalPts < 520000){
			$("#aminusgrade").addClass("grade-selected");
		}
		else if(totalPts < 540000){
			$("#agrade").addClass("grade-selected");
		}
		else{
			$("#aplusgrade").addClass("grade-selected");
		};
	};

	getSliderPts();
	getTotalPts();
	getGradePct();
	updateProgressBar();

});