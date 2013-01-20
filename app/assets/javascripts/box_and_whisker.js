var chart;

var rectWidth = 15;
$(document).ready(function() {
   chart = new Highcharts.Chart({
    chart: {
        renderTo: 'classStanding',
        defaultSeriesType: 'scatter',
        inverted: true,
        reflow: false,
        height: 200,
        margin: 50
        
    },
    title: {
          text: "Course Standings"
    },
    credits: {
       enabled: false
   },
    exporting: {
      enabled: false
    },  
   tooltip:{
       formatter: function()
       {
           var s = '<b>'+this.x+'</b>';
           for(var i = this.points.length-1; i>-1; i--)
           {
               colors = ["red","#444", "green", "#444", "blue"];
               s = s + ['<br>','<span style="color:' + colors[i] + '">', this.points[i].series.name, '</span>: ',
               '<b>', Highcharts.numberFormat(this.points[i].y, 0), '</b>'].join('');
           }
           return s;    
       },
       shared:true         
   },
   legend:{
       enabled:false
   },
   xAxis:{
    categories:[' ']
},
yAxis:{
    labels:{
        formatter: function(){ return this.value; }
    },
    title: {
        text: 'Score',
        align: 'high'
    }            
},
plotOptions:{       
},
series: [{
    name:'Minimum',
    marker:{enabled:false},
    data:[170000]
},
{

    name:'1st Quartile',
    marker:{enabled:false},
    data:[200000]
},
{
    name:'Median',
    marker:{enabled:false},
    data:[235000]
},{
    name:'3rd Quartile',
    marker:{enabled:false},
    data:[270000]
},
{
    name:'Maximum',
    marker:{enabled:false},
    data:[300000]
}
]
}, function(chart) {
    var min = chart.series[0].data;
    var quartile1 = chart.series[1].data;
    var median = chart.series[2].data;
    var quartile3 = chart.series[3].data;
    var max = chart.series[4].data;
    var translate = 0; // padding between symbols and boxes

    for(i=0; i<quartile1.length; i++)
    {

        // add the box for each category
       chart.renderer.rect(
             quartile3[i].plotY+chart.plotTop, //x
             quartile3[i].plotX-(rectWidth/2)+chart.plotLeft-translate, //y
             quartile1[i].plotY-quartile3[i].plotY, //width
             rectWidth, //height
             0) // cornerRadius
       .attr({
        'stroke-width': 1,
        stroke: '#aaa',
        fill: '#ccc',
        zIndex:4
        }).add();  

       // max value line
       chart.renderer.path(['M', max[i].plotY+chart.plotTop, max[i].plotX-(rectWidth/2)+chart.plotLeft-translate,
        'L', max[i].plotY+chart.plotTop, max[i].plotX+(rectWidth/2)+chart.plotLeft-translate ])
       .attr({
        'stroke-width': 1,
        stroke: 'blue',
        zIndex:5
    }).add();  

        // median value line
       chart.renderer.path(['M', median[i].plotY+chart.plotTop, median[i].plotX-(rectWidth/2)+chart.plotLeft-translate,
        'L', median[i].plotY+chart.plotTop, median[i].plotX+(rectWidth/2)+chart.plotLeft-translate])
       .attr({
        'stroke-width': 1,
        stroke: 'green',
        zIndex:5
    }).add();  

        // minimum value line
       chart.renderer.path(['M', min[i].plotY+chart.plotTop, min[i].plotX-(rectWidth/2)+chart.plotLeft-translate,
        'L', min[i].plotY+chart.plotTop, min[i].plotX+(rectWidth/2)+chart.plotLeft-translate])
       .attr({
        'stroke-width': 1,
        stroke: 'red',
        zIndex:5
    }).add();

       // line from box to endpoints
       chart.renderer.path(['M', min[i].plotY+chart.plotTop, min[i].plotX+chart.plotLeft-translate, 
        'L', max[i].plotY+chart.plotTop, max[i].plotX+chart.plotLeft-translate])
       .attr({
        'stroke-width': 1,
        stroke: '#aaa',
        zIndex:3
    })
       .add();          
   }

}
);

});