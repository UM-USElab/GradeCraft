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
        text: 'Course Points',
        style: {
          color: "#FFFFFF"
          }
        },
      subtitle: {
        text: '(so far)',
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
    
    var $wrapper = $('#userScoreSection');
    if($wrapper) { var userID = $('#userScoreSection').data('user-id');
      console.log(userID);
      
      // Get Assignment Type Info
      $.getJSON('predictor.json', { user_id: userID }, function(data) {

        // Populate series
        options.series = data;
        // Create the chart
        chart = new Highcharts.Chart(options);
      });
      
    };


});