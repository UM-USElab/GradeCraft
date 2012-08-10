var chart;
var soFarChart;

$(document).ready(function() {

// adds commas
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

// adds commas
	function addCommas(i){
		numWithCommas = i.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return numWithCommas;
	};

// Progress bars to student dashboard

	$('#scoreTotal').hide();
	$('#userBarTotal').hide();
	$('#showPossiblePts').hide();
    $('#soFarScoreToggle').hide();	

    $('a.dashboard-toggle').click(function(){
      $('.dashboard-toggle').toggle();
      return false;
	})

if ($("#userScoreSection").length > 0){

//TODO Hardcoded Assignment Types
	var group_project_score = removeCommas($("#group_project_score").html());
	var blogging_score = removeCommas($("#blogging_score").html());
	var attendance_score = removeCommas($("#attendance_score").html());
	var reading_score = removeCommas($("#reading_score").html());
	var section_score = removeCommas($("#section_score").html());	
	var essays_score = removeCommas($("#team_assignment_score").html());	
	var total_points = removeCommas($("#courseTotalPts").html());
	var totalSoFar = removeCommas($("#userBarTotal").html());

	chart = new Highcharts.Chart({
		colors: [			
			'#AA4643',			
		  '#DB843D',  
		  '#89A54E', 
			'#80699B', 
			'#3D96AE',
			'#f9ee14'

		],
		chart: {
			renderTo: 'userBarInProgress',
			type: 'bar',
			height:200,
			backgroundColor:null,
			width:500
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
			max:totalSoFar,
			title: {
				text: 'Available Points'
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
			width:500,
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
		// user profile  TODO Hardcoded graph labels
		series: [{
			name: 'Group Project',
			data: [group_project_score]	
		},{
			name: 'Blogging',
			data: [blogging_score]	
		},{
			name: 'Essays',
			data: [essays_score]	
		},{
			name: 'Section',
			data: [section_score]	
		},{
			name: 'Keeping Up With The Reading',
			data: [reading_score]	
		},{
			name: 'Attendance',
			data: [attendance_score]	
		}]
	});

	chart = new Highcharts.Chart({
		colors: [			
			'#AA4643',			
		  '#DB843D',  
		  '#89A54E', 
			'#80699B', 
			'#3D96AE'
		],
		chart: {
			renderTo: 'userBarTotal',
			type: 'bar',
			height:200,
			backgroundColor:null,
			width:500
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
			max:100,
			tickInterval: 5,
			title: {
				text: 'Total Points in Course'
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
			width:500,
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
			data: [team_assignment_score]	
		},{
			name: 'Assignments',
			data: [assignment_score]	
		},{
			name: 'Blogging',
			data: [blogging_score]	
		},{
			name: 'Keeping Up With The Reading',
			data: [reading_reaction_score]	
		},{
			name: 'Attendance',
			data: [attendance_score]	
		}]
	});

  }
});