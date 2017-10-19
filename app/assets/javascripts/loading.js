$( document ).ready(function() {

  // hide spinner
  $(".loading-pulse").hide();

  // show spinner on AJAX start
  $(document).ajaxStart(function(){
    $(".loading-pulse").show();
  });

  // hide spinner on AJAX stop
  $(document).ajaxStop(function(){
    $(".loading-pulse").hide();
  });

});
