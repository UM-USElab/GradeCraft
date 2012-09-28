var chartOptions = {
  chart: {
    renderTo: 'prediction',
    type: 'bar',
    height:170,
    backgroundColor:null,
    width:900
  },
  title: {
    text: ' ',
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
  },
  series: []
};

var AssignmentType = Backbone.Model.extend();

var AssignmentTypesArray = Backbone.Collection.extend({
  model: AssignmentType
});

var PredictorView = Backbone.View.extend({
  el: '#predictorPage',
  initialize: function() {
    this.collection = new AssignmentTypesArray();
    this.createAssignmentTypes();
    this.calculateScores();
    this.setupChart();
    this.collection.bind('change',this.render,this);
    this.$el = $(this.el);
    this.render();
  },
  render: function() {
    var chart = this.model;
    chart.yAxis[0].setExtremes(0,this.calculateCourseTotal());
    var scoreTotal = 0;
    this.collection.forEach(function(assignmentType,i) {
      chart.series[i].setData([assignmentType.get('score')])
      scoreTotal += assignmentType.get('score');
    });
    $('#predictor-score-display').html(scoreTotal);
    $('#predictor-course-total-display').html(this.calculateCourseTotal());
  },
  createAssignmentTypes: function() {
    var assignmentTypes = this.collection;
    $.each(this.$el.find('.slides li').not('.clone'),function(i,slide) {
      $slide = $(slide);
      if ($slide.attr('id') == 'slide-required') {
        return true; // Required slide just duplicates assignments from other slides, so we can ignore it
      }
      var assignmentTypeName = $slide.data('assignment-type-name');
      var assignmentTypeId = $slide.data('assignment-type-id');
      assignmentTypes.add(new AssignmentType({ id: assignmentTypeId, name: assignmentTypeName, score: 0 }));
    });
  },
  setupChart: function() {
    this.collection.forEach(function(assignmentType,i) {
      chartOptions.series.push({ name: assignmentType.get('name'), data: [assignmentType.get('score')] });
    });
    chartOptions.xAxis.categories = ' ';
    chartOptions.yAxis.max = this.calculateCourseTotal();
    this.model = new Highcharts.Chart(chartOptions);
  },
  events: { 
    'change input': 'calculateScores',
    'change select': 'calculateScores',
    'slidestop .slider': 'calculateScores'
  },
  calculateCourseTotal: function() {
    var courseTotal = 0;
    var $slide = this.$el.find('li#slide-badges')
    $.each($slide.find('input'), function(i,item) {
      var $item = $(item);
      if ($item.is(':checked')) {
        courseTotal += parseInt($item.val());
      }
    });
    courseTotal += parseInt(this.$el.data('course-total'));
    return courseTotal;
  },
  calculateScores: function() {
    var assignmentTypes = this.collection;
    $.each(this.$el.find('.slides li').not('.clone'),function(i,slide) {
      var $slide = $(slide);
      if ($slide.attr('id') == 'slide-required') {
        return true;
      }
      var assignmentTypeId = $slide.data('assignment-type-id');
      var score = 0;
      $.each($slide.find('input, select, .slider'), function(i,item) {
        var $item = $(item);
        if($item.is(':checkbox') && $item.is(':checked')) {
          score += parseInt($item.val());
        } else if ($item.is('select')) {
          score += parseInt($item.children('option:selected').val() || 0);
        } else if ($item.is('input[type="hidden"]')) {
          score += parseInt($item.val());
        } else if ($item.is('.ui-slider')) {
          score += parseInt($item.slider('value'));
        }
      });
      assignmentTypes.get(assignmentTypeId).set('score',score);
    });
  }
});
  


$(document).ready(function() {
  var $wrapper = $('#prediction');
  if ($wrapper.length) {
    new PredictorView();
  }
});

    
