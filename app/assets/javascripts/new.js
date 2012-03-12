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
	
	var chart;

		// if ($("#userScoreSection").length > 0){
		// 	
		// }
		// else if ($("#progressbar").length > 0){
		// 	
		// }
		// else{
		// 	
		// }
if ($("#progressbar").length > 0){		
// hide grade estimations
	$("#expected-grade > span").hide();
					
// set initial point values
		
	var attendancePts = parseInt($("#attendanceScore").html());
	var attendanceTotalPts = 0;
	var rxnPts = parseInt($("#rxnScore").html());
	var rxnSemiPts = 0;
	var rxnFinalPts = 0;
	var rxnTotalPts = 0;
	var blogPts = parseInt($("#bloggingScore").html());
	var subBlogPts = 0;
	var shortBlogPts = 0;
	var blogTotalPts = 0;
	var gameSelectionPts = 0;
    var lfpgPts = parseInt($("#lfpgScore").html());
	var lfpgTotalPts = 0;
	var bossPts = parseInt($("#bossBattleScore").html());
	var bossTotalPts = 0;
	var assignmentPts = 0;
	var teamPts = 0;
	var totalPts;						
		
//	---->
	var gameSelectionPts = 0;		
		
// adds up total points
	function getTotalPts(){
		totalPts = attendanceTotalPts + rxnTotalPts + blogTotalPts + sliderPts + teamPts
		// console.log(attendanceTotalPts +", " +rxnTotalPts +", " +blogTotalPts +", " +sliderPts +", " +teamPts)
	};				

	function updateGrinding(){
		attendancePredictorPts = ($("#classes-missed fieldset > input").filter(":checked").length)*5000;
		attendanceTotalPts = attendancePts + attendancePredictorPts
		if (attendanceTotalPts > 120000){
			attendanceTotalPts = 120000;
		};
		rxnPredictorPts = ($("#reactions-missed fieldset > input").filter(":checked").length)*5000;
		rxnTotalPts = rxnPts + rxnPredictorPts + rxnSemiPts + rxnFinalPts
		updateProgressBar();
	};

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
	function updateBlogging(){
		subBlogPts = ($("#substantial-blogposts").val())*5000;
		shortBlogPts = ($("#short-blogposts").val())*1000;
		blogTotalPts = blogPts + subBlogPts + shortBlogPts;
		if (blogTotalPts > 60000){
			blogTotalPts = 60000;
		};
	}

	$("#substantial-blogposts").change(function(){
		updateBlogging();
		updateProgressBar();
	});

	$("#short-blogposts").change(function(){
		updateBlogging();
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

	$( "#3" ).slider({
		value:0,
		min: 0,
		max: 120000,
		step: 1000,
		slide: function( event, ui ) {
			$("#total-3" ).val( ui.value );				
		},
		change: function( event, ui ) {
			updateProgressBar();				
		}
	});
	$( "#gameplay-poster-1-amount" ).val( $( "#3" ).slider( "value" ) );

	$( "#2" ).slider({
		value:0,
		min: 0,
		max: 120000,
		step: 1000,
		slide: function( event, ui ) {
			$("#total-2" ).val( ui.value );				
		},
		change: function( event, ui ) {
			updateProgressBar();				
		}
	});
	$( "#gameplay-poster-2-amount" ).val( $( "#2" ).slider( "value" ) );

	$( "#5" ).slider({
		value:0,
		min: 0,
		max: 200000,
		step: 1000,
		slide: function( event, ui ) {
			$("#total-5" ).val( ui.value );				
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#individual-project-1-amount" ).val( $( "#5" ).slider( "value" ) );

	$( "#6" ).slider({
		value:0,
		min: 0,
		max: 300000,
		step: 1000,
		slide: function( event, ui ) {
			$("#total-6" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#individual-project-2-amount" ).val( $( "#6" ).slider( "value" ) );

	$( "#7" ).slider({
		value:0,
		min: 0,
		max: 400000,
		step: 1000,
		slide: function( event, ui ) {
			$("#total-7" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#game-design-project-amount" ).val( $( "#7" ).slider( "value" ) );

	$( "#4" ).slider({
		value:0,
		min: 0,
		max: 160000,
		step: 1000,
		slide: function( event, ui ) {
			$("#total-4" ).val( ui.value );
		},
		change: function( event, ui ) {
			updateProgressBar();
		}
	});
	$( "#gameplay-reflection-amount" ).val( $( "#4" ).slider( "value" ) );

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
		poster1Pts = $( "#3" ).slider( "option", "value" );
		poster2Pts = $( "#2" ).slider( "option", "value" );		
		individualProject1Pts = $( "#5" ).slider( "option", "value" );
		individualProject2Pts = $( "#6" ).slider( "option", "value" );
		finalProjectPts = $( "#7" ).slider( "option", "value" );
		gameReflectionPts = $( "#4" ).slider( "option", "value" );
		
		if (isNaN(poster1Pts)){
			poster1Pts = 0;
		}
		else{
			poster1Pts = $( "#3" ).slider( "option", "value" );
		};
		
		if (isNaN(poster2Pts)){
			poster2Pts = 0;
		}
		else{
			poster2Pts = $( "#2" ).slider( "option", "value" );		
		};
		
		if (isNaN(individualProject1Pts)){
			individualProject1Pts = 0;
		}
		else{
			individualProject1Pts = $( "#5" ).slider( "option", "value" );
		};
		
		if (isNaN(individualProject2Pts)){
			individualProject2Pts = 0;
		}
		else{
			individualProject2Pts = $( "#6" ).slider( "option", "value" );			
		};
		
		if (isNaN(finalProjectPts)){
			finalProjectPts = 0;
		}
		else{
			finalProjectPts = $( "#7" ).slider( "option", "value" );
		};
		
		if (isNaN(gameReflectionPts)){
			gameReflectionPts = 0;
		}
		else{
			gameReflectionPts = $( "#4" ).slider( "option", "value" );
		};
		
		lfpgTotalPts = poster1Pts + poster2Pts + gameReflectionPts + lfpgPts;
		console.log(poster1Pts +", " +poster2Pts +", " +gameReflectionPts +", " +lfpgPts)
		bossTotalPts = individualProject1Pts + individualProject2Pts + finalProjectPts + bossPts;
		console.log(individualProject1Pts +", " +individualProject2Pts +", " +finalProjectPts +", " +bossPts)		
		// console.log(poster1Pts+", "+poster2Pts+", "+individualProject1Pts+", "+individualProject2Pts+", "+finalProjectPts+", "+gameReflectionPts)
		sliderPts = lfpgTotalPts + bossTotalPts;
		// console.log(sliderPts);
	};

// add commas to large numbers
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

// update the progress bar
	function updateProgressBar(){
		getSliderPts();
		// console.log(lfpgTotalPts+", "+bossTotalPts+", "+gameSelectionPts+", "+sliderPts)
		assignments_score = gameSelectionPts + sliderPts
		// console.log(assignments_score);
		attendance_score = attendanceTotalPts
		reading_reaction_score = rxnTotalPts
		blogging_score = blogTotalPts
		team_score = teamPts
		coursePts = 1400000
		// available_points = coursePts - totalPts
		getTotalPts();

		var chart;
		chart = new Highcharts.Chart({
			colors: [
				'#AA4643',			
				'#DB843D',  
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
				width:932
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
				max:1400000,
				tickInterval: 200000,
				title: {
					text: 'Points'
				},
				labels: {
					formatter: function(){
						return this.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					},
					style: {
						color: "#FFFFFF"
					},
					x: -20
				}
			},
			legend: {
				backgroundColor: null,
				borderColor:null,
				reversed: true,
				itemStyle: {
					color: '#CCCCCC'
				},
				itemHoverStyle: {
					color: '#CCCCCC',
					cursor: "default"
				},
				itemHiddenStyle: {
					color: '#3E576F'
				},
				width:932,
				style: {
					padding: 10
				}
			},
			tooltip: {
				formatter: function() {
					return ''+
						this.series.name +': '+ this.y +'';
				}
			},
			plotOptions: {
				series: {
					stacking: 'normal',
					events: {
						legendItemClick: function(event){
							return false;
						}
					}
				}	
			},
			series: [{
				name: 'Team Points',
				data: [team_score]	
			},{
				name: 'Assignments',
				data: [assignments_score]	
			},{
				name: 'Blogging',
				data: [blogging_score]	
			},{
				name: 'Reading Reactions',
				data: [reading_reaction_score]	
			},{
				name: 'Attendance',
				data: [attendance_score]	
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

	updateGrinding();
	getSliderPts();
	// getTotalPts();
	updateProgressBar();	
};	
});

