function cargarUbicacionInstitucion() {
	var latSelector = '#institucion_latitud';
	var lngSelector = '#institucion_longitud';

	var latitud = $(latSelector).val();
	var longitud = $(lngSelector).val();

	if (!latitud || !longitud) {
		latitud = -34.6425867
		longitud = -58.5659176;
	}

	var mapDisabled = !!(document.getElementById('mapDisabled'));
	var mapaUbicacion = new MapaUbicacion(latitud, longitud, latSelector, lngSelector, "googleMapPersona", mapDisabled);

  if (mapDisabled) {
    $('#institucion_direccion').prop('disabled', true);
  } else {
    $(latSelector).change(function() {
      var latitud = $(latSelector).val();
      var longitud = $(lngSelector).val();

      $.ajax({
        url: "/visits/getDireccion/",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: jQuery.param({ lat: latitud, lng : longitud})
      }).done(function(data) {
        $("#institucion_direccion").val(data);
      });
    });

    $('#institucion_direccion').change(function() {
      var direccion = $('#institucion_direccion').val();

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

  if (!$('#institucion_direccion').val()) {
    $(latSelector).change();
  }
};
