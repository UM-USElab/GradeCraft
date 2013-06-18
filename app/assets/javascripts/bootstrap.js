!function($) {
  var init = function() {
    $("a[rel=popover]").popover();
    $(".tooltip").tooltip();
    $("a[rel=tooltip]").tooltip();
  };
  $(init);
}(jQuery);
