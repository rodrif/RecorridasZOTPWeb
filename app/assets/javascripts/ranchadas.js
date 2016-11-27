
function cargarUbicacionRanchada() {
	var latSelector = '#ranchada_latitud';
	var lngSelector = '#ranchada_longitud';

	var latitud = $(latSelector).val();
	var longitud = $(lngSelector).val();

	if (!latitud || !longitud) {
		latitud = -34.6425867
		longitud = -58.5659176;
	}

  var mapDisabled = !!(document.getElementById('mapDisabled'));
	var mapaUbicacion = new MapaUbicacion(latitud, longitud, latSelector, lngSelector, "googleMapRanchada", mapDisabled);

	$('#new_ranchada_modal').ready(function() {
    $('#new_ranchada_modal').on('shown.bs.modal',function() {
      google.maps.event.trigger(mapaUbicacion.map, 'resize');
      mapaUbicacion.map.setCenter(new google.maps.LatLng(mapaUbicacion.latitud, mapaUbicacion.longitud));
    });
  });

};

$(document).ready(function(){

  $(document).bind('ajaxError', 'form#new_ranchada', function(event, jqxhr, settings, exception){
    if (settings.url.indexOf("ranchadas") > -1) {
      // note: jqxhr.responseJSON undefined, parsing responseText instead
      $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );
    }
  });

});