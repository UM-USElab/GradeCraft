var chart;
var soFarChart;

$(document).ready(function() {

	function removeCommas(i){
		console.log(i);
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

// Progress bars to student dashboard

	$('#scoreTotal').hide();
	$('#userBarTotal').hide();
	$('#showPossiblePts').hide();
    $('#soFarScoreToggle').hide();	

    $('a.toggle').click(function(){
      $('.toggle').toggle();
      return false;
	})

if ($("#userScoreSection").length > 0){

	var assignment_type_score = removeCommas($("#lfpg_score").html());
	var total_points = removeCommas($("#courseTotalPts").html());
	var totalSoFar = removeCommas($("#userBarTotal").html());

	chart = new Highcharts.Chart({
		colors: [			
			'#DB843D',  
			'#89A54E', 
			'#80699B', 
			'#3D96AE'
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
			name: 'Assignments',
			data: [assignment_score]	
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

	chart = new Highcharts.Chart({
		colors: [			
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
			max:1400000,
			tickInterval: 200000,
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
			name: 'Assignments',
			data: [assignment_score]	
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

  }
});