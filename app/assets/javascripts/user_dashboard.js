$(document).ready(function() {

	var options = {
    chart: {
      type: 'bar',
      height:150,
      backgroundColor:null,
    },
    title: {
      style: {
        color: "#FFFFFF"
      }
    },
    credits: {
      enabled: false
    },
    xAxis: {
      title: {
        text: ' '
      },
      labels: {
        style: {
          color: "#222"
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
        this.y +' points';
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
      $.getJSON('/users/predictor.json?in_progress=true', { user_id: userID }, function(data) {
        options.chart.renderTo = 'userBarInProgress';
        options.title = { text: 'Points so far' };
        options.xAxis.categories = { text: ' ' };
        options.yAxis.max = data.course_total
        options.series = data.scores
        chart = new Highcharts.Chart(options);
      });

      $.getJSON('/users/predictor.json', { user_id: userID }, function(data) {
        options.chart.renderTo = 'userBarTotal';
        options.title = { text: 'Total Points' };
        options.xAxis.categories = { text: ' ' };
        options.yAxis.max = data.course_total
        options.series = data.scores
        chart = new Highcharts.Chart(options);
      });
      
    };
    
    var options = {
    chart: {
      type: 'bar',
      height:150,
      backgroundColor:null,
    },
    title: {
      style: {
        color: "#FFFFFF"
      }
    },
    credits: {
      enabled: false
    },
    xAxis: {
      title: {
        text: ' '
      },
      labels: {
        style: {
          color: "#222"
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
        this.y +' points';
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
    
    var $wrapper = $('#userBarInProgressSim');
    if($wrapper.length) {
      var userID = $('#userID').data('user-id');
      
      // Get Assignment Type Info
      $.getJSON('/users/predictor.json?in_progress=true', { user_id: userID }, function(data) {
        options.chart.renderTo = 'userBarInProgressSim';
        options.title = { text: 'Points so far' };
        options.xAxis.categories = { text: ' ' };
        options.yAxis.max = data.course_total
        options.series = data.scores
        chart = new Highcharts.Chart(options);
      });

      $.getJSON('/users/predictor.json', { user_id: userID }, function(data) {
        options.chart.renderTo = 'userBarTotalSim';
        options.title = { text: 'Total Points' };
        options.xAxis.categories = { text: ' ' };
        options.yAxis.max = data.course_total
        options.series = data.scores
        chart = new Highcharts.Chart(options);
      });
      
    };


});
