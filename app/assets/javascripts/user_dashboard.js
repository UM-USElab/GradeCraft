$(document).ready(function() {
	var options = {
      chart: {
        renderTo: 'userBarInProgress',
        type: 'bar',
        height:200,
        backgroundColor:null,
        width:500
        },
      title: {
        text: '',
        style: {
          color: "#FFFFFF"
          }
        },
      subtitle: {
        text: 'Source:',
        x: -20
      },
      credits: {
        enabled: false
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
        max: 100000,
        title: {
          text: 'Available Points'
        }
      },
      labels: {
        formatter: function(){
          return this.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        },
      plotLines: [{
        value: 0,
        width: 1,
        color: '#808080'
        }]
      },
      tooltip: {
        formatter: function() {
          return '<b>'+ this.series.name +'</b><br/>'+
          this.x +': '+ this.y;
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
      legend: {
        backgroundColor: null,
        borderColor:null,
        reversed: true,
        itemStyle: {
          color: '#CCCCCC'
          }
        },
      series: []
      };
      
    var chart;
    // Get Assignment Type Info
    $.getJSON('/assignment_types.json', function(data) {
      // Populate series
      options.series = data;
      // Create the chart
      chart = new Highcharts.Chart(options);
    });
});