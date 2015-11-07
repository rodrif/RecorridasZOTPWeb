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
  script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyDtDVYB3gnF3bj6nMqzma3IHMNUvYe_rdY&callback=" + calllback;

  document.body.appendChild(script);
}

function initialize() {
  mapProp = {
    center: new google.maps.LatLng(-34.6425867,-58.5659176),
    zoom:15,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  
  map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
  map.addListener('rightclick', function() {
    window.location = '/people/new';
  });

  geoLocalizacion();
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
    window.location = '/people/' + marker.data.persona_id + '/edit';
  });
}

// Info window trigger function 
function mostrarInfoWindow(event, marker) { 
  // Create content  
  var contentString = marker.data.nombre + " " + marker.data.apellido + "<br /><hr />Coordinate: " + marker.data.latitud +"," + marker.data.longitud; 

  // Replace our Info Window's content and position 
  infowindow.setContent(contentString); 
  infowindow.idPersona = marker.data.persona_id;
  infowindow.open(map, marker);
} 

function geoLocalizacion() {
  var infoWindowNav = new google.maps.InfoWindow({map: map});
  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      infoWindowNav.setPosition(pos);
      infoWindowNav.setContent('Ubicación encontrada');
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindowNav, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindowNav, map.getCenter());
  }
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
}

 

