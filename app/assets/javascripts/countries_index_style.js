$(document).ready(function(){
  $(".countries-index-style").click(function(e){
    e.preventDefault();
    var divToReveal = $(this).attr('data-index-style-div');
    console.log(divToReveal);
    $(".country-index.country-index-show").removeClass("country-index-show");
    $("#" + divToReveal).addClass("country-index-show");
  })
});
