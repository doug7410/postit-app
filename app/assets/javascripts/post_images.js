// this makes the "choose image button add the url parameter to the end of the link"
$(document).ready(function(){

  var link = $("#choose_img_btn").attr("href");
  var url = $("#post_url").val();
  
  $("#choose_img_btn").attr("href", link + "?url=" + url );
  

  $("#post_url").change( function(){
    url = $("#post_url").val();
    var new_link = (link + "?url=" + url);
    $("#choose_img_btn").attr("href", new_link );
  })


});
