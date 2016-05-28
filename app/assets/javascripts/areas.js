// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

  $(document).bind('ajaxError', 'form#new_area', function(event, jqxhr, settings, exception) {
    if (settings.url.indexOf("areas") > -1) {
      // note: jqxhr.responseJSON undefined, parsing responseText instead
      $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );
    }
  });

});