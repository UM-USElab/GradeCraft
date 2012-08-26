// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require wysihtml5
//= require bootstrap-wysihtml5
//= require_tree .
//= require dataTables/jquery.dataTables
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require highcharts
//= require flexslider 


$(document).ready(function(){
  $('#some-textarea').wysihtml5();
});

$(function() {
 
  // Fix input element click problem
  $('.dropdown input, .dropdown label').click(function(e) {
    e.stopPropagation();
  });
});

$('#course_id').change(function() { $(this).closest('form').submit(); });

$('.nav-tabs').button();