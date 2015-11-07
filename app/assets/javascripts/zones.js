// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function MapaUbicacion(latitud, longitud, selectorLat, selectorLng) {

	var latitud;
	var longitud;
	var map;
	var mapProp;
	var selectorLat;
	var selectorLng;
	var marker;
	//var infowindow;

	this.latitud = latitud;
	this.longitud = longitud;
	this.selectorLat = selectorLat;
	this.selectorLng = selectorLng;

 	this.mapProp = {
		center: new google.maps.LatLng(this.latitud, this.longitud),
		zoom:15,
		mapTypeId: google.maps.MapTypeId.ROADMAP
  	};
	this.map = new google.maps.Map(document.getElementById("googleMap"), this.mapProp);
	this.refreshMarker();
	var self = this;
	this.map.addListener('click', function(event) {
		$(self.selectorLat).val(event.latLng.lat());
		$(self.selectorLng).val(event.latLng.lng());
		self.latitud = event.latLng.lat();
		self.longitud = event.latLng.lng();
		self.refreshMarker();
	});
}

MapaUbicacion.prototype.refreshMarker = function() {
	if (this.marker) {
		this.marker.setMap(null);
	}
	var latlng = new google.maps.LatLng(this.latitud, this.longitud);
	this.marker = new google.maps.Marker({
		position: latlng,
		map: this.map
	});
}

function cargarUbicacionZona() {
	var latitud = $('#zone_latitud').val();
	var longitud = $('#zone_longitud').val();

	if (!latitud || !longitud) {
		latitud = -34.6425867
		longitud = -58.5659176;
	}

	var mapaUbicacion = new MapaUbicacion(latitud, longitud, '#zone_latitud', '#zone_longitud');
};

function loadMapaScript(calllback) {
  var script = document.createElement("script");
  script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyDtDVYB3gnF3bj6nMqzma3IHMNUvYe_rdY&callback=" + calllback;
  document.body.appendChild(script);
}	