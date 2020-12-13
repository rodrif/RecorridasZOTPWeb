// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require materialize
//= require turbolinks
//= require_tree
//= require filterrific/filterrific-jquery

$(document).on('turbolinks:load', function() {
    $('.sidenav').sidenav();
    $(".dropdown-trigger").dropdown({
        coverTrigger: false,
        constrainWidth: false
    });
    $('select').formSelect();
    $('.modal').modal();
    $('.datepicker').datepicker({
        setDefaultDate: true,
        defaultDate: new Date(),
        yearRange: [new Date().getFullYear() - 100, new Date().getFullYear()],
        format: 'dd/mm/yyyy',
        i18n: {
            months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
            monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Set", "Oct", "Nov", "Dic"],
            weekdays: ["Domingo","Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"],
            weekdaysShort: ["Dom","Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
            weekdaysAbbrev: ["D","L", "M", "M", "J", "V", "S"],
        }
    });
});

function MapaUbicacion(latitud, longitud, selectorLat, selectorLng, idMapa, mapDisabled) {

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
	$(this.selectorLat).val(this.latitud);
	$(this.selectorLng).val(this.longitud);

 	this.mapProp = {
		center: new google.maps.LatLng(this.latitud, this.longitud),
		zoom:15,
		mapTypeId: google.maps.MapTypeId.ROADMAP
  	};
	this.map = new google.maps.Map(document.getElementById(idMapa), this.mapProp);
	this.refreshMarker();
	var self = this;
	if (!mapDisabled || typeof mapDisabled === 'undefined') {
		this.map.addListener('click', function(event) {
			$(self.selectorLat).val(event.latLng.lat());
			$(self.selectorLng).val(event.latLng.lng());
			$(self.selectorLat).trigger('change');
			self.latitud = event.latLng.lat();
			self.longitud = event.latLng.lng();
			self.refreshMarker();
		});
	}
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

function loadMapaScript(callback) {
	if (typeof google === 'undefined') {
	  var script = document.createElement("script");
	  script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyDtDVYB3gnF3bj6nMqzma3IHMNUvYe_rdY&callback=" + callback;
	  document.body.appendChild(script);
	} else {
		window[callback]();
	}
}

function downloadXlsx(buttonId, formId) {
    return downloadFile(buttonId, formId, 'xlsx');
}

function downloadWord(buttonId, formId) {
    return downloadFile(buttonId, formId, 'docx');
}

function downloadFile(buttonId, formId, extension) {
    $('#' + buttonId).click(function(ev) {
    var oldAction = $('#' + formId).attr('action');
    $('#' + formId).attr('action', oldAction + '.' + extension);
    $('#' + formId).submit();
    $('#' + formId).attr('action', oldAction);
    return false;
  });
}

(function($) {

  $.fn.modal_success = function(){
    // close modal
    this.modal('hide');

    // clear form input elements
    // todo/note: handle textarea, select, etc
    this.find('form input[type="text"]').val('');

    // clear error state
    this.clear_previous_errors();
  };

  $.fn.render_form_errors = function(errors){

    $form = this;
    this.clear_previous_errors();
    model = this.data('model');

    // show error messages in input form-group help-block
    $.each(errors, function(field, messages){
      $input = $('input[name="' + model + '[' + field + ']"]');
      var mensaje = messages.join(' y ');
      mensaje = mensaje.charAt(0).toUpperCase() + mensaje.slice(1);
      $input.closest('.form-group').addClass('has-error').find('.help-block').html(mensaje);
    });

  };

  $.fn.clear_previous_errors = function(){
    $('.form-group.has-error', this).each(function(){
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    });
  }

}(jQuery));
