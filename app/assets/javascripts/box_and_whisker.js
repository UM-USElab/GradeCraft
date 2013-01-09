/*
var chart;

var rectWidth = 35;
$(document).ready(function() {
   chart = new Highcharts.Chart({
    chart: {
        renderTo: 'classStanding',
        defaultSeriesType: 'scatter',
        reflow: false
    },
    credits: {
       enabled: false
   },
    exporting: {
      enabled: false
    },  
    title : {
      text: "Class Progress"
    },
   tooltip:{
       formatter: function()
       {
           var s = '<b>'+this.y+'</b>';
           for(var i = this.points.length-1; i>-1; i--)
           {
               colors = ["red","#444", "green", "#444", "blue"];
               s = s + ['<br>','<span style="color:' + colors[i] + '">', this.points[i].series.name, '</span>: ',
               '<b>', Highcharts.numberFormat(this.points[i].x, 0), '</b>'].join('');
           }
           return s; 
       },
       shared:true         
   },
   legend:{
       enabled:false
   },
yAxis:{
    labels:{
        formatter: function(){ return this.value; }
    }            
},
plotOptions:{       
},
series: [{
    name:'Minimum',
    marker:{enabled:false},
    data:[-20]
},
{

    name:'1st Quartile',
    marker:{enabled:false},
    data:[-10]
},
{
    name:'Median',
    marker:{enabled:false},
    data:[5]
},{
    name:'3rd Quartile',
    marker:{enabled:false},
    data:[12]
},
{
    name:'Maximum',
    marker:{enabled:false},
    data:[20]
}
]
}, function(chart) {
    var min = chart.series[0].data;
    var quartile1 = chart.series[1].data;
    var median = chart.series[2].data;
    var quartile3 = chart.series[3].data;
    var max = chart.series[4].data;
    var translate =10; // padding between symbols and boxes

    for(i=0; i<quartile1.length; i++)
    {

        // add the box for each category
       chart.renderer.rect(
             quartile3[i].plotY-(rectWidth/2)+chart.plotLeft-translate, //x
             quartile3[i].plotX+chart.plotTop, //y
             rectWidth, //width
             quartile1[i].plotX-quartile3[i].plotY, //height
             0) // cornerRadius
       .attr({
        'stroke-width': 1,
        stroke: '#aaa',
        fill: '#ccc',
        zIndex:4
        }).add();  

       // max value line
       chart.renderer.path(['M', max[i].plotY-(rectWidth/2)+chart.plotTop-translate, max[i].plotX+chart.plotLeft,
        'V', max[i].plotY+(rectWidth/2)+chart.plotTop-translate, max[i].plotX+chart.plotTop ])
       .attr({
        'stroke-width': 1,
        stroke: 'blue',
        zIndex:5
    }).add();  

        // median value line
       chart.renderer.path(['M',median[i].plotY-(rectWidth/2)+chart.plotTop-translate,median[i].plotX+chart.plotLeft,
        'V',median[i].plotY+(rectWidth/2)+chart.plotTop-translate,median[i].plotX+chart.plotTop])
       .attr({
        'stroke-width': 1,
        stroke: 'green',
        zIndex:5
    }).add();  

        // minimum value line
       chart.renderer.path(['M', min[i].plotY-(rectWidth/2)+chart.plotTop-translate, min[i].plotX+chart.plotLeft,
        'V', min[i].plotY+(rectWidth/2)+chart.plotTop-translate, min[i].plotX+chart.plotTop])
       .attr({
        'stroke-width': 1,
        stroke: 'red',
        zIndex:5
    }).add();

       // line from box to endpoints
       chart.renderer.path(['M', min[i].plotX, min[i].plotY,
        'L', max[i].plotX+chart.plotTop-translate, min[i].plotY])
       .attr({
        'stroke-width': 1,
        stroke: 'red',
        zIndex:3
    })
       .add();          
   }

}
);

});
*/