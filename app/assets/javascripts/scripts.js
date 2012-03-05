$(document).ready(function(){

// hide grade estimations
	$("#expected-grade > span").hide();
	
// set initial point values
	var attendancePts = 0;
	var rxnPts = 0;
	var rxnSemiPts = 0;
	var rxnFinalPts = 0;
	var subBlogPts = 0;
	var shortBlogPts = 0;	
	var sliderPts = 0;
	var gameSelectionPts = 0;
	var teamPts = 0;
	var totalPts;
	var gradePct = (totalPts/1245000)*100				

// adds up total points
	function getTotalPts(){
		totalPts = attendancePts + rxnPts + rxnSemiPts + rxnFinalPts + subBlogPts + shortBlogPts + sliderPts + gameSelectionPts + teamPts
	};

// removes points per class or reading reaction missed
	
	function updateGrinding(){
		attendancePts = ($("#classes-missed fieldset > input").filter(":checked").length)*5000;
		if (attendancePts > 120000){
			attendancePts = 120000;
		};
		rxnPts = ($("#reactions-missed fieldset > input").filter(":checked").length)*5000;
		updateProgressBar();
	}
	

	$("#classes-missed .select-all").click(function(e){
		e.preventDefault();
		$("#classes-missed fieldset > .class-checkbox").each(function(){
			$(this).attr("checked","checked");
		});
		updateGrinding();
	});
	
	$("#reactions-missed .select-all").click(function(e){
		e.preventDefault();
		$("#reactions-missed fieldset > .class-checkbox").each(function(){
			$(this).attr("checked",true);
		});
		updateGrinding();
	});
	
	$("#classes-missed .select-none").click(function(e){
		e.preventDefault();		
		$("#classes-missed fieldset > .class-checkbox").each(function(){
			$(this).attr("checked", false);
		});
		updateGrinding();
	});
	
	$("#reactions-missed .select-none").click(function(e){
		e.preventDefault();		
		$("#reactions-missed fieldset > .class-checkbox").each(function(){
			$(this).attr("checked", false);
		});
		updateGrinding();
	});
	
	$("#classes-missed fieldset > .class-checkbox").change(function(){
		updateGrinding();					
	});
	
	$("#reactions-missed fieldset > .class-checkbox").change(function(){
		updateGrinding();			
	});
	
	$("#reaction-semis").change(function(){
		rxnSemiPts = ($(this).val())*2000;
		updateGrinding();		
	});
	$("#reaction-finals").change(function(){
		rxnFinalPts = ($(this).val())*3000;
		updateGrinding();
	});

// adds points for blog posts

	$("#substantial-blogposts").change(function(){
		subBlogPts = ($(this).val())*5000;
		updateProgressBar();
	});
	
	$("#short-blogposts").change(function(){
		shortBlogPts = ($(this).val())*1000;
		updateProgressBar();
	});

	$("#game-selection-checkbox").click(function(){
		gameSelectionStr = $(this).val();
		if ($(this).attr("checked")){
			gameSelectionPts = parseInt(gameSelectionStr)
		}
		else{
			gameSelectionPts = 0;
		}
		updateProgressBar();
	});

// create sliders for training missions and boss battles

	$( "#gameplay-poster-1-slider" ).slider({
		value:0,
		min: 0,
		max: 120000,
		step: 1000,
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
		step: 1000,
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
		step: 1000,
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
		step: 1000,
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
		step: 1000,
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
		step: 1000,
		slide: function( event, ui ) {
			$("#gameplay-reflection-total" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#gameplay-reflection-amount" ).val( $( "#gameplay-reflection-slider" ).slider( "value" ) );
	
	$("#team-point-values").change(function(){
		teamPtsVal = $(this).val();
		teamPts = parseInt(teamPtsVal);				
		updateProgressBar();
	});

// set slider values
	var poster1Pts = 0;
	var poster2Pts = 0;	
	var individualProject1Pts = 0;
	var individualProject2Pts = 0;
	var finalProjectPts = 0;
	var gameReflectionPts = 0;

// get slider point values
	function getSliderPts(){
		poster1Pts = $( "#gameplay-poster-1-slider" ).slider( "option", "value" );
		poster2Pts = $( "#gameplay-poster-2-slider" ).slider( "option", "value" );		
		individualProject1Pts = $( "#individual-project-1-slider" ).slider( "option", "value" );
		individualProject2Pts = $( "#individual-project-2-slider" ).slider( "option", "value" );
		finalProjectPts = $( "#game-design-project-slider" ).slider( "option", "value" );
		gameReflectionPts = $( "#gameplay-reflection-slider" ).slider( "option", "value" );

		sliderPts = poster1Pts + poster2Pts + individualProject1Pts + individualProject2Pts + finalProjectPts + gameReflectionPts;
		getGradePct();
	};

// get percentage
	function getGradePct(){
		getTotalPts();
		gradePct = (totalPts/1245000)*100
	};

// add commas to large numbers
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
		
// update the progress bar
	function updateProgressBar(){
		getSliderPts();
		
		// $("#progressbar").progressbar({
		// 	value: gradePct
		// });

		standard_score = sliderPts + gameSelectionPts
		attendance_score = attendancePts
		reading_reaction_score = rxnPts + rxnSemiPts + rxnFinalPts
		blogging_score = subBlogPts + shortBlogPts
		team_score = teamPts
		coursePts = 1400000
		available_points = coursePts - totalPts

		var chart;
		chart = new Highcharts.Chart({
			colors: [
				'#CCCCCC',
				'#DB843D', 
				'#AA4643', 
				'#89A54E', 
				'#80699B', 
				'#3D96AE'
			],
			chart: {
				renderTo: 'progressbar',
				type: 'bar',
				reflow: true,
				height:200,
				backgroundColor:null,
				width:700
			},
			credits: {
			        enabled: false
			    },
			title: {
				text: '',
				style: {
					color: "#FFFFFF"
				}
			},
			xAxis: {
				categories: [''],
				labels: {
					style: {
						color: "#FFFFFF"
					}
				}
			},
			yAxis: {
				min: 0,
				title: {
					text: 'Points'
				},
				labels: {
					style: {
						color: "#FFFFFF"
					}
				}
			},
			legend: {
				backgroundColor: null,
				borderColor:null,
				reversed: true,
				itemStyle: {
					color: '#CCCCCC'
				},
				itemHiddenStyle: {
					color: '#3E576F'
				},
				width:700
			},
			tooltip: {
				formatter: function() {
					return ''+
						this.series.name +': '+ this.y +'';
				}
			},
			plotOptions: {
				series: {
					stacking: 'normal'
				}
			},
			series: [{
				name: 'Available Points',
				data: [available_points]	
			},{
				name: 'Team Points',
				data: [team_score]	
			},{
				name: 'Blogging',
				data: [blogging_score]	
			},{
				name: 'Reading Reactions',
				data: [reading_reaction_score]	
			},{
				name: 'Attendance',
				data: [attendance_score]	
			},{
				name: 'Assignments',
				data: [standard_score]	
			}]
		});
		
		ptsCommas = numberWithCommas(totalPts);
		
		$("#expected-points").html(ptsCommas);


// update the points --> letter grade table
		$("#expected-grade > span").hide();

		if (totalPts < 600000){
			$("#doomgrade").show();
		}
		else if (totalPts < 650000){
			$("#dplusgrade").show();
		}
		else if(totalPts < 700000){
			$("#cminusgrade").show();
				}
		else if(totalPts < 750000){
			$("#cgrade").show();
		}
		else if(totalPts < 800000){
			$("#cplusgrade").show();
		}
		else if(totalPts < 850000){
			$("#bminusgrade").show();
		}
		else if(totalPts < 900000){
			$("#bgrade").show();
		}
		else if(totalPts < 950000){
			$("#bplusgrade").show();
		}
		else if(totalPts < 1000000){
			$("#aminusgrade").show();
		}
		else if(totalPts < 1245000){
			$("#agrade").show();
		}
		else{
			$("#aplusgrade").show();
		};
	};

	getSliderPts();
	getTotalPts();
	getGradePct();
	updateProgressBar();

});