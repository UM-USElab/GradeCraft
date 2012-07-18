
if ($("#predictorWrapper").length > 0){	
	$("#projectedPoints").click(function(){
		$("#predictionWrapper").toggleClass("toggleOn");
		$("#pointsArw").toggleClass("toggleOn");			
		$("#prediction").toggle();
		updateProgressBar();
		return false;
	});

// utility scripts

	// add commas
	function addCommas(i){
		numWithCommas = i.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return numWithCommas;
	};	
	
	// Remove commas from numbers when grabbing them from page
	function removeCommas(i){
		if (i == null) {
			return 0;
		}
		else if (i.indexOf(",") >= 0){
			integer = parseInt(i.replace(/,/g, ""));
			return integer
		}
		else{
			return parseInt(i);
		}
	};	
	
	
	// handle 'select all' button
	$(".select-all").click(function(e){
		e.preventDefault();
		$(this).siblings().find("input").each(function(){
			$(this).attr("checked","checked");
		});
		updateProgressBar($(this));		
	});
		
	// handle 'select none' button
	$(".select-none").click(function(e){
		$(this).siblings().find("input").each(function(){
			$(this).attr("checked", false);
		});
		updateProgressBar($(this));		
	});


	// get data from server
	// loop through 
	var jsonloop = function(){
		addjsondata:
		for(i=0; i<50; i++){
			$.ajax('assignment_types/'+i+'.json', {
				dataType: 'json',
				success: fillAssignArray,
				error: function(){
					break addjsondata;
				} 
			});
		}
	};
	jsonloop();

	// this is what the json data should look like when it comes through, one object per assignment type
	// keys and values I've used may not match what you've used. they're easy enough to change here
	
	// {
	// 	"id":1,
	// 	"name": "individual paper/project",
	// 	"assignmentType":"slider",
	// 	"pointType":"range",
	// 	"minScore":0,
	// 	"maxScore":160000,
	// 	"step":1,
	// 	"currScore":0
	// }
	
	// create assignments array
	var assignmentObjects = [];

	// create scores array
	var scoresArray = [];

	// add assignment object to array
	var fillAssignArray = function(json){
		assignmentObjects.push(json);
	};
	
// update the progress bar
	var updateProgressBar = function(input){
		var scoreUpdate = 0;
		if(input != undefined){
			var assignSection = input.parents().filter(".gradeSection");
			var assignId = parseInt(assignSection.attr("id"));			
		}else{
			var assignId = "";
		}
		
	// get student's current grades
		$(assignSection).find(".point-value").each(function(){
		// from checkboxes
			if ($(this).attr("type") === "checkbox"){
				if($(this).attr("checked") === "checked"){
					scoreUpdate += parseInt($(this).val());
				}
			}
		// from sliders	
			else if ($(this).attr("type") === "number"){
				scoreUpdate += parseInt($(this).val());	
			}
		// from select
			else if ($(this).hasClass("predictor-select")){
				scoreUpdate += parseInt($(this).val());
			}			
			else if ($(this).hasClass("slider-value")){
				scoreUpdate += removeCommas($(this).text());	
			}else{
				console.log("check for non-checkbox or slider case: "+$(this));
				console.log("type: "+$(this).attr("type"));
			}			
		});
		
	// save new score for updated element 		
		totalScore = 0;
		for(i = 0; i < assignmentObjects.length; i++){
			if(assignmentObjects[i].id === assignId){
	// this requires an element in each assignment section with a class of '.current_score' which contains
	// the user's current score on that particular assignment 
				scoresArray[i].data = parseInt(removeCommas(assignSection.children().filter(".current_score").html())) + scoreUpdate;
			}
			totalScore += parseInt(scoresArray[i].data);
		}		
		$("#expectedPointsValue").text(addCommas(totalScore));

	// set interval for progress bar
		var courseInterval;
		var setCourseInterval = function(){
			if (courseTotal <= 100000){
				courseInterval = 10000;
			}
			else if(courseTotal <= 500000){
				courseInterval = 50000
			}
			else if(courseTotal <= 1000000){
				courseInterval = 100000
			}
			else if(courseTotal <= 2000000){
				courseInterval = 200000
			}else{
				courseInterval = 500000
			}
		}
		setCourseInterval();
		
	// create progress bar
		var chart;
		if ($("#predictionWrapper").hasClass("toggleOn")){
			var legend = {
				align: 'left',				
				backgroundColor: null,
				borderColor:null,				
				enabled: true,				
				itemHoverStyle: {
					color: '#fff',
					cursor: "default"
				},
				itemMarginTop:10,
				itemStyle: {
					color: '#fff'
				},
				layout: 'vertical',				
				padding:15,
				reversed: true
			};
			var chartDetails = {
				renderTo: 'score',
				type: 'column',
				backgroundColor:null,
				height:250,
				width:450
			}
		}else{
			var chartDetails = {
				renderTo: 'score',
				type: 'column',
				backgroundColor:null,
				width:150,
			}
		}
		chart = new Highcharts.Chart({
			chart: chartDetails,
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
// spec ranges				
				max:(courseTotal*1.1),
				tickInterval: courseInterval,
				tickLength: 5,
				title: {
					text: 'Points'
				},
				opposite: true,
				labels: {
					formatter: function(){
						return addCommas(this.value);
					},
					style: {
						color: "#FFFFFF"
					},
					x: 10
				}
			},
			legend: legend,
			tooltip: {
				enabled: false				
			},
			plotOptions: {
				series: {
					pointWidth: 30,
					stacking: 'normal'
				}	
			},
			series: scoresArray
		});
		
	}

// iterate through array, creating data for each grade type
	var courseTotal = 0;
	// create array to hold progress bar point totals 
	
	for(i = 0; i < assignmentObjects.length; i++){

		scoresArray.push({
			name: assignmentObjects[i].name,
			data: [0]	
		});
		
		// find course point total
		courseTotal += assignmentObjects[i].max_value;	

	// generate UI elements

	if (assignmentObjects[i].points_predictor_display === "slider"){
		// create sliders
			var sliderId = "#slider-"+parseInt(assignmentObjects[i].id);
			var sliderTotalId = "#total-slider-"+parseInt(assignmentObjects[i].id);
			var step = assignmentObjects[i].step_value;
			$(sliderId).slider({
				value: 0,
				min: 0,
				max: assignmentObjects[i].max_value,
				range: "min",
				step: step,
				slide: function(event, ui) {
					sliderTotalId = "#total-"+$(this).attr('id');
					var sliderMin = assignmentObjects[($(this).parents().filter(".gradeSection").attr('id'))-1].minimum_score;
					if (ui.value < sliderMin){
						$(sliderTotalId).text((addCommas(0+" points - you haven't met the minimum of "+sliderMin+" points")));						
					}else{
						$(sliderTotalId).text((addCommas((ui.value).toFixed(0)))+" points");
					}
				},
				change: function(event,ui) {
					updateProgressBar($(this));				
				}
			});
		}	
	}
	
// event handler for UI elements
	$("#predictorWrapper .point-value").change(function(){
		updateProgressBar($(this));
	});
	
// create initial progress bar on page load
	updateProgressBar();
};	
});