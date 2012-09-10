
$(document).ready(function() {

	var options = {
    chart: {
      renderTo: 'prediction',
      type: 'bar',
      height:170,
      backgroundColor:null,
      width:900
    },
    title: {
      text: 'PROJECTED POINTS:',
      style: {
        color: "#FFFFFF"
      }
    },
    subtitle: {
      text: ''
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
    }
  };
    
  var chart;
  
  var $wrapper = $('#prediction');
  if($wrapper.length) {
    var userID = $('#userID').data('user-id');

    $.getJSON('predictor.json?in_progress=true', { user_id: userID }, function(data) {
      options.chart.renderTo = 'prediction';
      options.xAxis.categories = { text: ' ' };
     /* options.subtitle = { text: data.scores.sum } */
      options.yAxis.max = data.course_total
      options.series = data.scores
      $wrapper.data('scores',data.scores)
      chart = new Highcharts.Chart(options);

      $('.assignment input').each(function() {
        $input = $(this);
        $input.click(function() {
          if ($input.is(':checked')) {
            change = $input.val() - $input.data('original-value');
          } else {
            change = 0 - $input.data('original-value');
          };
          chart.series[0].setData([change])
        });
      });

/*
      setTimeout(function() {
        chart.series[0].setData([8000])
      },3000);
      */
    });

    
  };

});
