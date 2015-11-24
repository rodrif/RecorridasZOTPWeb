// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function cargarUbicacionPersona() {
	var latSelector = '#person_visits_attributes_0_latitud';
	var lngSelector = '#person_visits_attributes_0_longitud';

	var latitud = $(latSelector).val();
	var longitud = $(lngSelector).val();

	if (!latitud || !longitud) {
		latitud = -34.6425867
		longitud = -58.5659176;
	}

	var mapDisabled = !!(document.getElementById('mapDisabled'));
	var mapaUbicacion = new MapaUbicacion(latitud, longitud, latSelector, lngSelector, "googleMapPersona", mapDisabled);

	cargarUbicacionZona();
	cargarUbicacionRanchada();
};

$(function() {
  return $(document).on('change', '#person_area_id', function(evt) {
    return $.ajax('/people/update_zonas', {
      type: 'GET',
      dataType: 'script',
      data: {
        area_id: $("#person_area_id option:selected").val(),
        selector_zona: 'person_zone_id'
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus + " " + errorThrown);
      },
      success: function(data, textStatus, jqXHR) {
        return console.log("Dynamic area select OK!");
      }
    });
  });
});

$(function() {
  return $(document).on('change', '#person_zone_id', function(evt) {
    return $.ajax('/people/update_ranchadas', {
      type: 'GET',
      dataType: 'script',
      data: {
        zone_id: $("#person_zone_id option:selected").val(),
        selector_ranchada: 'person_ranchada_id'
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus + " " + errorThrown);
      },
      success: function(data, textStatus, jqXHR) {
        return console.log("Dynamic zone select OK!");
      }
    });
  });
});

