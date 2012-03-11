var chart;
$(document).ready(function() {

if ($("#userScoreSection").length > 0){
	
	var lfpg_score = parseInt($("#lfpg_score").html());
	var boss_battle_score = parseInt($("#boss_battle_score").html());
	var attendance_score = parseInt($("#attendance_score").html());
	var reading_reaction_score = parseInt($("#reading_reaction_score").html());
	var blogging_score = parseInt($("#blogging_score").html());	
	if ( isNaN(blogging_score) == true){
		blogging_score = 0
	}
	else{
		blogging_score = parseInt($("#blogging_score").html());
	}
	var assignment_score = lfpg_score + boss_battle_score	
	var total_points = parseInt($("#courseTotalPts").html());
	
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