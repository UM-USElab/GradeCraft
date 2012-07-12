$(document).ready(function(){
	
	$('#myInfo').hide();
	$('#myInfoContainer .btn-group a').click(function(){
		$('#myInfo').toggle();
		$('#myInfoContainer .btn-group .dropdown-toggle').toggleClass('btn-info');
	});
	// $("#myInfo").hide();
	// $("#myInfoContainer a").click(function(){
	// 	$("#myInfo").toggle();
	// });

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
if ($("#predictorWrapper").length > 0){	
	$("#projectedPoints").click(function(){
		$("#predictionWrapper").toggleClass("toggleOn");
		$("#pointsArw").toggleClass("toggleOn");			
		$("#prediction").toggle();
		updateProgressBar();
		return false;
	});
	// $(window).scroll(function(){
	// 	if ($(window).scrollTop() > 118){
	// 		$("#predictionWrapper").css({
	// 			"background-color": "rgba(55,55,55,.96)",
	// 			"position":"fixed",
	// 			"top":"0"
	// 		});
	// 		$("#content").css({
	// 			"padding-top":"232px"
	// 		});
	// 	}else{
	// 		$("#predictionWrapper").css({
	// 			"background-color": "rgba(55,55,55,0)",
	// 			"position":"static"
	// 		});
	// 		$("#content").css({
	// 			"padding-top":"20px"
	// 		});
	// 	};
	// });
	
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
	
	// THIS IS DUMMY DATA ADDED MANUALLY 		
	var data = [
		[1,'individual paper/project','slider','range',0,160000,1,0],
		[2,'essay','slider','range',60000,160000,1,0],
		[3,'group project','slider','range',0,180000,1,0],
		[4,'attendance','checkboxes','single',0,60000,1,0],
		[5,'reading reactions','checkboxes','single',0,50000,1,0],
		[6,'quizzes','dropdown','multiple',0,20000,1,0],
		[7,'blogging','slider','range',0,60000,5000,0]		
	];
	
	// create assignments array
	var assignmentObjects = [];

	// create scores array
	var scoresArray = [];

	// assignment constructor

	var Assignment = function(id,name,assignmentType,pointType,minScore,maxScore,step,currScore){
		// id number for assignment given by rails	
		this.id = id;

		// name of assignment
		this.name = name;

		// assignment types: checkboxes, on/off, dropdown, slider
		this.assignmentType = assignmentType;

		// point types: single, range
		this.pointType = pointType;

		// min score for earning points on the assignment
		this.minScore = minScore;

		// max total score 
		this.maxScore = maxScore;
		
		// step for sliders
		this.step = step;

		// current score for this assignment
		this.currScore = (currScore > 0) ? currScore : 0;

		// predictor score for this assignment
		this.predictorScore = 0;
	};

	// loop through data to construct each assignment

	for(i = 0; i < data.length; i++){
		var id, name, assignmentType, pointType, maxScore, step, currScore;
		for(e = 0; e < data[i].length; e++){
			switch(e){
				case 0:
					id = data[i][e]
					break;
				case 1:
					name = data[i][e]
					break;
				case 2:
					assignmentType = data[i][e]
					break;
				case 2:
					pointType = data[i][e]
					break;
				case 4:
					maxScore = data[i][e]
					break;
				case 5:
					step = data[i][e]
					break;
				case 6:
					currScore = data[i][e]
					break;	
			}
		}
		assignmentObjects.push(new Assignment(id,name,assignmentType,pointType,maxScore,step,currScore));
	}
	
// update the progress bar
	var updateProgressBar = function(input){
		var scoreUpdate = 0;
		if(input != undefined){
			var assignSection = input.parents().filter(".gradeSection");
			var assignId = parseInt(assignSection.attr("id"));
			//console.log("assignSection: "+assignSection.html());
			//console.log("input id: "+ assignId);			
		}else{
			var assignId = "first";
		}
		
	// get student's current grades
		$(assignSection).find(".point-value").each(function(){
		// from checkboxes
			if ($(this).attr("type") === "checkbox"){
				if($(this).attr("checked") === "checked"){
					//console.log("this checkbox: "+$(this).val());
					scoreUpdate += parseInt($(this).val());
				}
			}
		// from sliders	
			else if ($(this).attr("type") === "number"){
				scoreUpdate += parseInt($(this).val());	
				//console.log("type: "+$(this).attr("type"));
			}
		// from select
			else if ($(this).hasClass("predictor-select")){
				scoreUpdate += parseInt($(this).val());
				console.log("value: "+$(this).val());	
			}			
			else if ($(this).hasClass("slider-value")){
				scoreUpdate += removeCommas($(this).text());	
				//console.log("value: "+parseInt($(this).text()));
			}else{
				console.log("check for non-checkbox or slider case: "+$(this));
				console.log("type: "+$(this).attr("type"));
			}			
		});
		
	// save new score for updated element 		
		totalScore = 0;
		for(i = 0; i < assignmentObjects.length; i++){
			if(assignmentObjects[i].id === assignId){
				scoresArray[i].data = [assignmentObjects[i].currScore + scoreUpdate]
			}
			totalScore += parseInt(scoresArray[i].data);
		}		
		$("#expectedPointsValue").text(addCommas(totalScore));

	// set interval for progress bar
		var courseInterval;
		console.log(courseTotal);
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
		console.log(courseInterval);
		
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
			// legend: {enabled: false},
			tooltip: {
				enabled: false				
//				formatter: function() {
//				                return this.series.name +': '+ +this.y;
//				            }
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
		courseTotal += assignmentObjects[i].maxScore;	

	// generate UI elements

	if (assignmentObjects[i].assignmentType === "slider"){
		// create sliders
			var sliderId = "#slider-"+parseInt(assignmentObjects[i].id);
			var sliderTotalId = "#total-slider-"+parseInt(assignmentObjects[i].id);
			if(assignmentObjects[i].pointType === "range"){
				var step = assignmentObjects[i].maxScore/100;
			}else{
				var step = assignmentObjects[i].step;
			}
			$(sliderId).slider({
				value: 0,
				min: 0,
				max: assignmentObjects[i].maxScore,
				range: "min",
				step: step,
				slide: function(event, ui) {
					sliderTotalId = "#total-"+$(this).attr('id');
					var sliderMin = assignmentObjects[($(this).parents().filter(".gradeSection").attr('id'))-1].minScore;
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
		else if(assignmentObjects[i].assignmentType === "checkboxes"){
			
		}
		else{
			
		}	
	}
	
// event handler for UI elements
	$("#predictorWrapper .point-value").change(function(){
		updateProgressBar($(this));
		//console.log("input handler: "+$(this));
	});
	
// create initial progress bar on page load
	updateProgressBar();
};	
});