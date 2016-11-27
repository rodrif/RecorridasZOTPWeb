// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function cargarUbicacionVisita() {
	var latitud = $('#visit_latitud').val();
	var longitud = $('#visit_longitud').val();

	if (!latitud || !longitud) {
		latitud = -34.6425867
		longitud = -58.5659176;
	}

	var mapDisabled = !!(document.getElementById('mapDisabled'));
	var mapaUbicacion = new MapaUbicacion(latitud, longitud, '#visit_latitud', '#visit_longitud', 'googleMapVisita', mapDisabled);

	$('#visit_latitud').change(function() {
		var latitud = $('#visit_latitud').val();
		var longitud = $('#visit_longitud').val();

		$.ajax({
		  url: "/visits/getDireccion/",
		  contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
		  data: jQuery.param({ lat: latitud, lng : longitud})
		}).done(function(data) {
		  $("#visit_direccion").val(data);
		});
	});

	$('#visit_direccion').change(function() {
		var direccion = $('#visit_direccion').val();

		$.ajax({
		  url: "/visits/getCoordenadas/",
		  contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
		  data: jQuery.param({ direccion: direccion})
		}).done(function(data) {
			if (data) {
			  $("#visit_latitud").val(data[0]);
			  $("#visit_longitud").val(data[1]);
			  var mapaUbicacion = new MapaUbicacion($('#visit_latitud').val(), $('#visit_longitud').val(), '#visit_latitud', '#visit_longitud', 'googleMapVisita');
			} else {
				alert('direccion inválida');
			}
		});
	});

	if (!$('#visit_direccion').val()) {
		$('#visit_latitud').change();
	}

}
