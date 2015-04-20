var listaPersonasViewModels;

function loadMapaScript(calllback) {
  var script = document.createElement("script");
  script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyDtDVYB3gnF3bj6nMqzma3IHMNUvYe_rdY&callback=" + calllback;

  document.body.appendChild(script);
}

function initialize() {

  var mapProp = {
    center:new google.maps.LatLng(51.508742,-0.120850),
    zoom:5,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

  addPins();
}

function addPins() {
	alert(listaPersonasViewModels);
}

function loadIndexAction (personasViewModels) {
	listaPersonasViewModels = $('#personas').data;

	loadMapaScript('initialize');
}

