// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  /*
  // Always send the authenticity_token with ajax
  $(document).ajaxSend(function(event, request, settings) {
      if ( settings.type == 'post' ) {
          settings.data = (settings.data ? settings.data + "&" : "")
                  + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
          request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      }
  });

  // When I say html I really mean script for rails
  $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;  
  */

  // display link and url appearance for new pages
  function update_page_preview() {
    // var raw_name = $("#page_name").val();
    // var raw_title = $("#page_title").val();
    // var raw_description = $("#page_description").val();
    // var preview_data = "";
    // if (raw_name != "")
      // preview_data = "name=" + encodeURIComponent(raw_name);
    // if (raw_title != "") {
      // if (preview_data != "")
        // preview_data = preview_data + "&"
      // preview_data = preview_data + "title=" + encodeURIComponent(raw_title);
    // }
    // if (raw_description != "") {
      // if (preview_data != "")
        // preview_data = preview_data + "&"
      // preview_data = preview_data + "description=" + encodeURIComponent(raw_description);
    // }
    $.ajax({
      type: 'GET',
      url: '/pages/preview',
      data: {
        name:  $("#page_name").val(),
        title:  $("#page_title").val(),
        description:  $("#page_description").val()
      },
      success: function(data) {
        $(".preview_load").html(data);
      }
    });
    // $.ajax({
      // type: 'GET',
      // url: '/pages/preview',
      // data: preview_data,
      // success: function(data) {
        // $(".preview").html(data);
      // }
    // });
  }
  //var page_name = $("#page_name");
  //if (page_name.length) {
  //  $("#page_name").ready(update_page_preview);
  //}
  /*
  update_page_preview();
  $("#page_name").change(update_page_preview);
  $("#page_name").keyup(update_page_preview);
  $("#page_title").change(update_page_preview);
  $("#page_title").keyup(update_page_preview);
  $("#page_description").change(update_page_preview);
  $("#page_description").keyup(update_page_preview);
  */
});
