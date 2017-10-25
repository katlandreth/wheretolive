$(document).ready(function(){
  $(function() {

    $(".filter-form-wrapper").on("click", "#submit-filter-button", function(){
      console.log("button clicked");
      $('div[id^=category]').addClass("hide-filter");
    });

    $('#showCategorySwitches').click(function() {
      $('div[id^=category]').not('#category_switches').addClass("hide-filter");
      $('#category_switches').toggleClass("hide-filter");
    });

    $('#showCategoryDealBreakers').click(function() {
      $('div[id^=category]').not('#category_deal_breakers').addClass("hide-filter");
      $('#category_deal_breakers').toggleClass("hide-filter");
    });


    $('#showCategoryWeights').click(function() {
      $('div[id^=category]').not('#category_weights').addClass("hide-filter");
      $('#category_weights').toggleClass("hide-filter");
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
