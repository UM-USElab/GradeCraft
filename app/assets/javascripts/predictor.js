/*
$(document).ready(function(){

// Get Course Info
	var courseInfo = function(){
		addjsondata:
			$.get('/current_course.json', {
				dataType: 'json',
				success: function(){
               }, 
				error: function(){
				} 
			});
	};

	courseInfo();
	
  // Course Constructor
  	var Course = function(current_course,coursePoints){
    	this.current_course = id;
    	this.coursePoints = total_points
  	}

// Get Assignment Type Info
	var assignmentTypeInfo = function(){
		addjsondata:
			$.get('/assignment_types.json', {
				dataType: 'json',
				success: function(){
               }, 
				error: function(){
				} 
			});
	};	
	
	assignmentTypeInfo();
	
		// Assignment Constructor
	var AssignmentType = function(assignmentID,assignmentTypeName,assignmentTypeDisplay,pointType,maxValue,currScore){
  	this.assignmentID = id;
		this.assignmentTypeName = name;
		// assignment types: Slider, Select List, Fixed
		this.assignmentTypeDisplay = points_predictor_display;
		// point types: true, false
		this.pointType = levels;
		this.maxValue = max_value;
		// current score for this assignment
		this.currScore = (currScore > 0) ? currScore : 0;
		// predictor score for this assignment
		this.predictorScore = 0;
	};

	// Get Assignment Info
	var assignmentInfo = function(){
		addjsondata:
			$.get('/assignments.json', {
				dataType: 'json',
				success: function(){
               }, 
				error: function(){
				} 
			});
	};
	
	assignmentInfo();
	
	// Assignment Constructor
  	var Assignment = function(id,coursePoints){
    	this.assignmentID = id;
    	this.assignmentName = name;
    	this.assignmentPointTotal = point_total; 
    	this.assignmentDescription = description;
    	this.assignmentDueDate = due_date;
    	this.assignmentTypeMaster = assignment_type_id;
    	this.gradeSchemeMaster = grade_scheme_id;
    	this.gradeScopeSetting = grade_scope;
    	this.assignmentVisible = visible;
    	this.assignmentRequired = required;
  	}

// Get Course Grade Scheme Info
	var courseGradeSchemeInfo = function (){
  	addjsondata:
  	 $.get('/course_grade_schemes.json', {
    	 dataType: 'json',
    	 success: function(){
    	 },
    	 error: function (){
    	 }
    });
	};

	courseGradeSchemeInfo();
	
	// Course Grade Scheme Element constructor
	var CourseGradeSchemeElement = function(courseGradeSchemeID,letterGrade,courseGradeSchemeElementName,lowFange,highRange){
  	this.courseGradeSchemeID = id;
  	this.letterGrade = letter_grade;
  	this.courseGradeSchemeElementName = name;
  	this.lowRange = low_range;
  	this.highRange = high_range;
	}

	// create assignments array
	var assignmentObjects = [];

	// create scores array
	var scoresArray = [];

	// loop through data to construct each assignment

	for(i = 0; i < data.length; i++){
		var id, name, assignmentType, pointType, maxScore, currScore;
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
					currScore = data[i][e]
					break;
			}
		}
		assignmentObjects.push(new Assignment(id,name,assignmentType,pointType,maxScore,currScore));
	}
	
// update the progress bar
	var updateProgressBar = function(input){
		var scoreUpdate = 0;
		if(input != undefined){
			var assignSection = input.parents().filter(".gradeSection");
			var assignId = parseInt(assignSection.attr("id"));
		}else{
			var assignId = "first";
		}
		
	// get student's current grades
		$(assignSection).find("input").each(function(){
		// from checkboxes
			if ($(this).attr("type") === "checkbox"){
				if($(this).attr("checked") === "checked"){
					scoreUpdate += parseInt($(this).val());
				}
			}
		// from sliders	
			else if ($(this).attr("type") === "number"){
				scoreUpdate += parseInt($(this).val());	
			}else{
				console.log("check for non-checkbox or slider case")
			}			
		});
		
	// save new score for updated element 		
		for(i = 0; i < assignmentObjects.length; i++){
			if(assignmentObjects[i].id === assignId){
				scoresArray[i].data = [assignmentObjects[i].currScore + scoreUpdate]
			}
		}		
		
	// create progress bar
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
				renderTo: 'score',
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
				max: courseSum,
				tickInterval: courseSum/100,
				title: {
					text: 'Points'
				},
				labels: {
					formatter: function(){
						return addCommas(this.value);
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
						this.series.name +': '+ addCommas(this.y) +'';
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
			series: scoresArray
		});
	}

// iterate through array, creating data for each grade type

	// create array to hold progress bar point totals 
	
	for(i = 0; i < assignmentObjects.length; i++){

		scoresArray.push({
			name: assignmentObjects[i].name,
			data: [0]	
		});	

	// generate UI elements

	if (assignmentObjects[i].assignmentType === "Slider"){
		// create sliders
			var sliderId = "#slider-"+parseInt(assignmentObjects[i].id);
			var sliderTotalId = "#total-slider-"+parseInt(assignmentObjects[i].id);			
		
			$(sliderId).slider({
				value:0,
				min: 0,
				max: assignmentObjects[i].maxScore,
				step: assignmentObjects[i].maxScore/100,
				slide: function(event, ui) {
					sliderTotalId = "#total-"+$(this).attr('id');
					$(sliderTotalId).val(((ui.value).toFixed(0)));
				},
				change: function(event,ui) {
					updateProgressBar($(this));				
				}
			});
		}
		else if(assignmentObjects[i].assignmentType === "Fixed"){
			
		}
		else{
			
		}	
	}
	
// event handler for UI elements
	$("#predictor input").change(function(){
		updateProgressBar($(this));
	});
	
// create initial progress bar on page load
	updateProgressBar();
});
*/