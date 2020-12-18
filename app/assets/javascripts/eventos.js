function cargarUbicacionEvento() {
    var latSelector = '#evento_latitud';
    var lngSelector = '#evento_longitud';

    var latitud = $(latSelector).val();
    var longitud = $(lngSelector).val();

    if (!latitud || !longitud) {
        latitud = -34.5803526
        longitud = -58.4360354;
    }

    var mapDisabled = !!(document.getElementById('mapDisabled'));
    var mapaUbicacion = new MapaUbicacion(latitud, longitud, latSelector, lngSelector, "googleMapPersona", mapDisabled);

    if (mapDisabled) {
        $('#evento_ubicacion').prop('disabled', true);
    } else {
        $(latSelector).change(function() {
            var latitud = $(latSelector).val();
            var longitud = $(lngSelector).val();

            $.ajax({
                url: "/visits/getDireccion/",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                data: jQuery.param({ lat: latitud, lng : longitud})
            }).done(function(data) {
                $("#evento_ubicacion").val(data);
            });
        });

        $('#evento_ubicacion').change(function() {
            var direccion = $('#evento_ubicacion').val();

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

    if (!$('#evento_ubicacion').val()) {
        $(latSelector).change();
    }
};
