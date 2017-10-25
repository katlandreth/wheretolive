$(document).ready(function(){
  $(function() {

    $(".filter-form-wrapper").on("click", "#submit-filter-button", function(){
      $('.modal-overlay').addClass("mo-hidden");
      $('div[id^=category]').addClass("hide-filter");
    });

    $('#showCategorySwitches').click(function() {
      $('div[id^=category]').not('#category_switches').addClass("hide-filter");
      $('#category_switches').toggleClass("hide-filter");
      toggleOverlay();
    });

    $('#showCategoryDealBreakers').click(function() {
      $('div[id^=category]').not('#category_deal_breakers').addClass("hide-filter");
      $('#category_deal_breakers').toggleClass("hide-filter");
      toggleOverlay();
    });


    $('#showCategoryWeights').click(function() {
      $('div[id^=category]').not('#category_weights').addClass("hide-filter");
      $('#category_weights').toggleClass("hide-filter");
      toggleOverlay();
    });

  })
});

$(document).ready(function(){
  $('body').on('click', '.btn.active', function(e){
      e.stopImmediatePropagation();
      e.preventDefault();

      $(this).removeClass('active');
      $('input:radio[name="options"]', this).prop('checked', false);
  })
})


function toggleOverlay(){
  var filterModalsCount = $('.hide-filter').length;

  if( filterModalsCount < 3 ) {
    $('.modal-overlay').removeClass("mo-hide");
    $('.modal-overlay').addClass("mo-show");
  }
  else {
    $('.modal-overlay').removeClass("mo-show");
    $('.modal-overlay').addClass("mo-hide");
  }
};
