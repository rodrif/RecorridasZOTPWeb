var listaPersonasViewModels;
var map;
var mapProp;

function loadMapaScript(calllback) {
  var script = document.createElement("script");
  script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyDtDVYB3gnF3bj6nMqzma3IHMNUvYe_rdY&callback=" + calllback;

  document.body.appendChild(script);
}

function initialize() {

  mapProp = {
    center:new google.maps.LatLng(51.508742,-0.120850),
    zoom:5,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  
  map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

  addPins();
}

function addPins() {
 
  for (var i = 0; i < listaPersonasViewModels.length; i++) {

    addMarker(listaPersonasViewModels[i]);
  }

}

function loadIndexAction(personasViewModels) {
	listaPersonasViewModels = $('#personas').data('personas');

	loadMapaScript('initialize');
}

function addMarker(personaViewModel) {

  var latlng = new google.maps.LatLng(personaViewModel.latitud, personaViewModel.longitud);

  var marker = new google.maps.Marker({
    position: latlng,
    title: personaViewModel.nombre
  });

  marker.setMap(map);
}


