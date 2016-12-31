$(function() {
  return $(document).on('change', '#aaa_area_id', function(evt) {
    return $.ajax('/common/update_zonas_filter', {
      type: 'GET',
      dataType: 'script',
      data: {
        area_id: $("#aaa_area_id option:selected").val(),
        selector_zona: 'zona_zone_id'
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus + " " + errorThrown);
      },
      success: function(data, textStatus, jqXHR) {
        return console.log("update_zonas_filter OK!");
      }
    });
  });
});

$(function() {
  return $(document).on('change', '#zona_zone_id', function(evt) {
    return $.ajax('/common/update_personas', {
      type: 'GET',
      dataType: 'script',
      data: {
        area_id: $("#aaa_area_id option:selected").val(),
        zone_id: $("#zona_zone_id option:selected").val(),
        selector_persona: 'pedido_person_id'
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus + " " + errorThrown);
      },
      success: function(data, textStatus, jqXHR) {
        return console.log("update_personas OK!");
      }
    });
  });
});
