$(document).ready(function() {

	var options = {
    chart: {
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
    credits: {
      enabled: false
    },
    xAxis: {
      labels: {
        style: {
          color: "#FFFFFF"
        }
      }
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Available Points'
      }
    },
    labels: {
      plotLines: [{
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
  };
      
    var chart, categories, assignment_type_name, scores;
    
    var $wrapper = $('#userBarInProgress');
    if($wrapper.length) {
      var userID = $('#userID').data('user-id');
      
      // Get Assignment Type Info
      $.getJSON('predictor.json?in_progress=true', { user_id: userID }, function(data) {
        options.chart.renderTo = 'userBarInProgress';
        options.subtitle = { text: '(so far)' };
        options.xAxis.categories = [data.student_name];
        options.yAxis.max = data.course_total
        options.series = data.scores
        chart = new Highcharts.Chart(options);
      });

      $.getJSON('predictor.json', { user_id: userID }, function(data) {
        options.chart.renderTo = 'userBarTotal';
        options.subtitle = { text: '(total)' };
        options.xAxis.categories = [data.student_name];
        options.yAxis.max = data.course_total
        options.series = data.scores
        chart = new Highcharts.Chart(options);
      });
      
    };


});
