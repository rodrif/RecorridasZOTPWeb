$(document).ready(function(){


  $('#notificacion_frecuencia_tipo_id').change(function() {
    $('#notificacion_frecuencia').show();
    if ($('#notificacion_frecuencia_tipo_id').val() == 1) { // Unica
      $('#notificacion_fecha_hasta').hide();
      $('#notificacion_frecuencia_cant').hide();
      $('#label_fecha_desde').text('Fecha');
      $('#frecuencia-tipo-content').removeClass("col-md-5").addClass("col-md-10");
    } else {
      $('#label_fecha_desde').text('Fecha desde');
      $('#notificacion_fecha_hasta').show();
      $('#notificacion_frecuencia_cant').show();
      $('#frecuencia-tipo-content').removeClass("col-md-10").addClass("col-md-5");
    }
  });

  $('#notificacion_notificacion_tipo_id').change(function() {
    if ($('#notificacion_notificacion_tipo_id').val() == 4) { // Calendario
      $('#label_fecha_desde').text('Fecha desde');
      $('#notificacion_fecha_hasta').show();
      $('#notificacion_frecuencia').hide();
    } else {
      $('#notificacion_frecuencia_tipo_id').trigger("change");
    }
  });

  if ($('#notificacion_notificacion_tipo_id').val() == 4) { // Calendario)
    $('#notificacion_notificacion_tipo_id').trigger("change");
  } else {
    $('#notificacion_frecuencia_tipo_id').trigger("change");
  }
});