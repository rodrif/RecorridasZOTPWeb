// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function cargarUbicacionVisita() {
	var latitud = $('#visit_latitud').val();
	var longitud = $('#visit_longitud').val();

	if (!latitud || !longitud) {
		latitud = -34.6425867
		longitud = -58.5659176;
	}

	var mapaUbicacion = new MapaUbicacion(latitud, longitud, '#visit_latitud', '#visit_longitud', 'googleMapVisita');
};