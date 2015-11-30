// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function cargarUbicacionZona() {
	var latitud = $('#zone_latitud').val();
	var longitud = $('#zone_longitud').val();

	if (!latitud || !longitud) {
		latitud = -34.6425867
		longitud = -58.5659176;
	}

	var mapaUbicacion = new MapaUbicacion(latitud, longitud, '#zone_latitud', '#zone_longitud', 'googleMapZona');

  $('#new_zone_modal').ready(function() {
    $('#new_zone_modal').on('shown.bs.modal',function() {
      google.maps.event.trigger(mapaUbicacion.map, 'resize');
      mapaUbicacion.map.setCenter(new google.maps.LatLng(mapaUbicacion.latitud, mapaUbicacion.longitud));
    });
  });
};

$(document).ready(function(){
  
  $(document).bind('ajaxError', 'form#new_zone', function(event, jqxhr, settings, exception){
    if (settings.url.indexOf("zones") > -1) {
      // note: jqxhr.responseJSON undefined, parsing responseText instead
      $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );
    }
  });

});

