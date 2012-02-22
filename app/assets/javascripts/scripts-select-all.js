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

// removes points per class or reading reaction missed
	$("#attendance-yes").click(function(){
		$("#classes-missed").slideDown('fast');
		attendancePts = 65000;
		rxnPts = 50000;
		updateProgressBar();
	});
	
	$(".class-checkbox").change(function(){
		attendancePts = 65000 - ($("#classes-missed > input").filter(":checked").length)*5000;
		updateProgressBar();			
	});
	
	$("#attendance-no").click(function(){
		$("#classes-missed").slideUp();
		attendancePts = 65000;
		rxnPts = 50000;			
		$("#classes-missed").find(":checked").each(function(){
			$(this).removeAttr("checked");
		})
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
		// console.log(blogPts);
		updateProgressBar();
	});

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
		value:0,
		min: 0,
		max: 80000,
		step: 2000,
		slide: function( event, ui ) {
			// $("#game-selection-skill" ).val( ui.value-20000 );
			$("#game-selection-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();				
		}

	});
	$( "#game-selection-amount" ).val( $( "#game-selection-slider" ).slider( "value" ) );

	$( "#gameplay-poster-1-slider" ).slider({
		value:0,
		min: 0,
		max: 120000,
		step: 5000,
		slide: function( event, ui ) {
			$("#gameplay-poster-1-total" ).val( ui.value );				
		},
		change: function( event, ui ) {
			updateProgressBar();				
		}
	});
	$( "#gameplay-poster-2-amount" ).val( $( "#gameplay-poster-2-slider" ).slider( "value" ) );
	
	$( "#gameplay-poster-2-slider" ).slider({
		value:0,
		min: 0,
		max: 120000,
		step: 5000,
		slide: function( event, ui ) {
			$("#gameplay-poster-2-total" ).val( ui.value );				
		},
		change: function( event, ui ) {
			updateProgressBar();				
		}
	});
	$( "#gameplay-poster-2-amount" ).val( $( "#gameplay-poster-2-slider" ).slider( "value" ) );

	$( "#individual-project-1-slider" ).slider({
		value:0,
		min: 0,
		max: 200000,
		step: 5000,
		slide: function( event, ui ) {
			$("#individual-project-1-total" ).val( ui.value );				
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#individual-project-1-amount" ).val( $( "#individual-project-1-slider" ).slider( "value" ) );

	$( "#individual-project-2-slider" ).slider({
		value:0,
		min: 0,
		max: 300000,
		step: 5000,
		slide: function( event, ui ) {
			$("#individual-project-2-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#individual-project-2-amount" ).val( $( "#individual-project-2-slider" ).slider( "value" ) );

	$( "#game-design-project-slider" ).slider({
		value:0,
		min: 0,
		max: 400000,
		step: 5000,
		slide: function( event, ui ) {
			$("#game-design-project-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#game-design-project-amount" ).val( $( "#game-design-project-slider" ).slider( "value" ) );

	$( "#gameplay-reflection-slider" ).slider({
		value:0,
		min: 0,
		max: 160000,
		step: 5000,
		slide: function( event, ui ) {
			$("#gameplay-reflection-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#gameplay-reflection-amount" ).val( $( "#gameplay-reflection-slider" ).slider( "value" ) );

// set slider values
	var gameplaySelectionPts = 0;
	var poster1Pts = 0;
	var poster2Pts = 0;	
	var individualProject1Pts = 0;
	var individualProject2Pts = 0;
	var finalProjectPts = 0;
	var gameReflectionPts = 0;

// get slider point values
	function getSliderPts(){
		gameplaySelectionPts = $( "#game-selection-slider" ).slider( "option", "value" );
		poster1Pts = $( "#gameplay-poster-1-slider" ).slider( "option", "value" );
		poster2Pts = $( "#gameplay-poster-2-slider" ).slider( "option", "value" );		
		individualProject1Pts = $( "#individual-project-1-slider" ).slider( "option", "value" );
		individualProject2Pts = $( "#individual-project-2-slider" ).slider( "option", "value" );
		finalProjectPts = $( "#game-design-project-slider" ).slider( "option", "value" );
		gameReflectionPts = $( "#gameplay-reflection-slider" ).slider( "option", "value" );

		sliderPts = gameplaySelectionPts + poster1Pts + poster2Pts + individualProject1Pts + individualProject2Pts + finalProjectPts + gameReflectionPts;
		getGradePct();
	};

// get percentage
	function getGradePct(){
		getTotalPts();
		gradePct = (totalPts/1245000)*100
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
