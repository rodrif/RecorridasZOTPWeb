// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function cargarUbicacionPersona() {
	var latSelector = '#person_visits_attributes_0_latitud';
	var lngSelector = '#person_visits_attributes_0_longitud';

	var latitud = $(latSelector).val();
	var longitud = $(lngSelector).val();

	if (!latitud || !longitud) {
		latitud = -34.5803526
		longitud = -58.4360354;
	}

	var mapDisabled = !!(document.getElementById('mapDisabled'));
	var mapaUbicacion = new MapaUbicacion(latitud, longitud, latSelector, lngSelector, "googleMapPersona", mapDisabled);

	cargarUbicacionZona();
	//cargarUbicacionRanchada();

  if (mapDisabled) {
    $('#person_visits_attributes_0_direccion').prop('disabled', true);
  } else {
    $(latSelector).change(function() {
      var latitud = $(latSelector).val();
      var longitud = $(lngSelector).val();

      $.ajax({
        url: "/visits/getDireccion/",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: jQuery.param({ lat: latitud, lng : longitud})
      }).done(function(data) {
        $("#person_visits_attributes_0_direccion").val(data);
      });
    });

    $('#person_visits_attributes_0_direccion').change(function() {
      var direccion = $('#person_visits_attributes_0_direccion').val();

      $.ajax({
        url: "/visits/getCoordenadas/",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: jQuery.param({ direccion: direccion})
      }).done(function(data) {
        if (data) {
          $(latSelector).val(data[0]);
          $(lngSelector).val(data[1]);
          var mapaUbicacion = new MapaUbicacion($(latSelector).val(), $(lngSelector).val(), latSelector, lngSelector, 'googleMapPersona');
        } else {
          alert('direccion inválida');
        }
      });
    });
  }

  if (!$('#person_visits_attributes_0_direccion').val()) {
    $(latSelector).change();
  }
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
  return $(document).on('change', '#ranchada_area_id', function(evt) {
    return $.ajax('/people/update_zonas', {
      type: 'GET',
      dataType: 'script',
      data: {
        area_id: $("#ranchada_area_id option:selected").val(),
        selector_zona: 'ranchada_zone_id'
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
  return $(document).on('change', '#familia_area_id', function(evt) {
    return $.ajax('/people/update_zonas', {
      type: 'GET',
      dataType: 'script',
      data: {
        area_id: $("#familia_area_id option:selected").val(),
        selector_zona: 'familia_zone_id'
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

$(function() {
  return $(document).on('change', '#person_zone_id', function(evt) {
    return $.ajax('/people/update_familias', {
      type: 'GET',
      dataType: 'script',
      data: {
        zone_id: $("#person_zone_id option:selected").val(),
        selector_familia: 'person_familia_id'
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus + " " + errorThrown);
      },
      success: function(data, textStatus, jqXHR) {
        return console.log("Dynamic zone (update_familias) select OK!");
      }
    });
  });
});

$(function() {
  return $(document).on('change', '#familia_zone_id', function(evt) {
    return $.ajax('/people/update_ranchadas', {
      type: 'GET',
      dataType: 'script',
      data: {
        zone_id: $("#familia_zone_id option:selected").val(),
        selector_ranchada: 'familia_ranchada_id'
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
