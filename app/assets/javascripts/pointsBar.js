var chart;
$(document).ready(function() {

if ($("#userScoreSection").length > 0){
	
	standard_score = parseInt($("#standard_score").html());
	attendance_score = parseInt($("#attendance_score").html());
	reading_reaction_score = parseInt($("#reading_reaction_score").html());
	blogging_score = parseInt($("#blogging_score").html());
	if (blogging_score > 0) {
	}
	else{
		blogging_score = 0
	}
	total_points = parseInt($("#courseTotalPts").html());
	available_points = parseInt(total_points - (standard_score + attendance_score + reading_reaction_score + blogging_score));
	
	chart = new Highcharts.Chart({
		colors: [
			'#CCCCCC', 
			'#AA4643', 
			'#89A54E', 
			'#80699B', 
			'#3D96AE', 
			'#DB843D', 
			'#92A8CD', 
			'#A47D7C', 
			'#B5CA92'
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
			width:500
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
			name: 'Available Points (unearned)',
			data: [available_points]
		}, {
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
	}
});