$(document).ready(function() {
    var options = {
            chart: {
                renderTo: 'teamChart',
                type: 'bar'
            },
            title: {
                text: 'Team Scores'
            },
            subtitle: {
                text: ' '
            },
            xAxis: {
                categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania'],
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Score',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                formatter: function() {
                    return ''+
                        this.series.name +': '+ this.y +' millions';
                }
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -100,
                y: 100,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true
            },
            credits: {
                enabled: false
            }
        });
    });
    
    var chart, categories, assignment_type_name, scores;
    
    var $wrapper = $('#teamChart');
    if($wrapper.length) {
      
      // Get Assignment Type Info
      $.getJSON('/teams/analytics.json', function(data) {
        options.chart.renderTo = 'teamChart';
        options.title = { text: 'Team Statistics' };
        options.xAxis.categories = { text: ' ' };
        options.yAxis.max = data.course_total
        options.series = data.scores
        chart = new Highcharts.Chart(options);
      });
      
    };
    
});