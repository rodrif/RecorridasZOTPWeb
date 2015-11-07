// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function cargarUbicacionZona() {
	var latitud = $('#zone_latitud').val();
	var longitud = $('#zone_longitud').val();

	if (!latitud || !longitud) {
		latitud = -34.6425867
		longitud = -58.5659176;
	}

	var mapaUbicacion = new MapaUbicacion(latitud, longitud, '#zone_latitud', '#zone_longitud');
};