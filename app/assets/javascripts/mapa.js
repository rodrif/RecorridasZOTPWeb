var listaPersonasViewModels;
var map;
var mapProp;
var infowindow;

function loadIndexAction() {

  listaPersonasViewModels = $('#personas').data('personas');

  loadMapaScript('initialize');
}

function loadMapaScript(calllback) {

  var script = document.createElement("script");
  script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyDtDVYB3gnF3bj6nMqzma3IHMNUvYe_rdY&callback=" + calllback;

  document.body.appendChild(script);
}

function initialize() {

  mapProp = {
    center:new google.maps.LatLng(-34.6425867,-58.5659176),
    zoom:15,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  
  map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

  addPersonasToMap();
}

function addPersonasToMap() {
 
  for (var i = 0; i < listaPersonasViewModels.length; i++) {

    addMarker(listaPersonasViewModels[i]);
  }

  infowindow = new google.maps.InfoWindow();
 }

function addMarker(personaViewModel) {

  var latlng = new google.maps.LatLng(personaViewModel.latitud, personaViewModel.longitud);

  var marker = new google.maps.Marker({
    position: latlng,
    map: map,
    title: personaViewModel.nombre,
    data: personaViewModel
  });

  //Listen for click event  
  google.maps.event.addListener(marker, 'mouseover', function() { 
    //map.setCenter(new google.maps.LatLng(marker.position.lat(), marker.position.lng())); 
    //map.setZoom(18); 
    mostrarInfoWindow(event, marker); 
  });

  google.maps.event.addListener(marker, 'click', function() {
    window.location = '/people/' + marker.data.persona_id;
  });
}

// Info window trigger function 
function mostrarInfoWindow(event, marker) { 
  // Create content  
  var contentString = marker.data.nombre + "<br /><br /><hr />Coordinate: " + marker.data.latitud +"," + marker.data.longitud; 

  // Replace our Info Window's content and position 
  infowindow.setContent(contentString); 
  infowindow.idPersona = marker.data.persona_id;
  infowindow.open(map, marker);
} 

 

