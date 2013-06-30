// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap
//= require highcharts
//= require highcharts-more
//= require flexslider 
//= require underscore.min
//= require backbone.min
//= require selectToUISlider.jQuery
//= require jquery.omniselect
//= require gradecraft
//= require_tree .
//= require jquery.dynatable
//= require ckeditor/init

$(document).ready(function(){
  $('#gradeCurious').popover();

/*
  
  $('#classBoxandWhiskerPopover').click(function() {
    $(this).popover({ html: true }).popover('toggle');
    box_and_whiskers('toggle');
  });
*/
/*

  $('.modal').modal();
*/

  $('#easyTab a').click(function (e) {
    e.preventDefault();
    $('#easyTab a[href="#basic"]').tab('show'); // Select tab by name
    $('#easyTab a:first').tab('show'); // Select first tab
    $('#easyTab a:last').tab('show'); // Select last tab
    $('#easyTab li:eq(2) a').tab('show'); // Select third tab (0-indexed)
    
  });
  
  $('.toolTip').tooltip();

	$("#sortableTable").tablesorter();
	
	$('#navbar').affix();
 
  $('.slider').each(function(i,slider) {
    $slider = $(slider)
    $slider.slider({
      max: $slider.attr('max')
    });
    $slider.on('slide', function(event, ui){
      $(slider).prev("div.assignment > span").html(ui.value)
    });
  });
  
  //$('select').selectToUISlider();
  
  // Fix input element click problem
  $('.dropdown input, .dropdown label').click(function(e) {
    e.stopPropagation();
  });
    
	$('#userBarTotalSim').show();	

$('#course_id').change(function() { $(this).closest('form').submit(); });

$('.nav-tabs').button();

    
	
	// handle 'select all' button
	$(".select-all").click(function(e){
		var $link = $(this);
		
		e.preventDefault();
		$link.parents().find("input").prop("checked", "checked");
	});
		
	// handle 'select none' button
	$(".select-none").click(function(e){
	 var $link = $(this);
	 
		e.preventDefault();
		$link.parents().find("input").prop("checked", false);
		
	});

  
});
	
