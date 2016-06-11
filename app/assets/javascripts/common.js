$(function() {
  return $(document).on('change', '#filterrific_with_area_id', function(evt) {
    return $.ajax('/common/update_zonas_filter', {
      type: 'GET',
      dataType: 'script',
      data: {
        area_id: $("#filterrific_with_area_id option:selected").val(),
        selector_zona: 'filterrific_with_zone_id'
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus + " " + errorThrown);
      },
      success: function(data, textStatus, jqXHR) {
        return console.log("Dynamic filterrific area select OK!");
      }
    });
  });
});

// TODO refactor
// function onChangeAjax(url, data) {
//     return $(document).on('change', data.selectorChange, function(evt) {
//         return $.ajax(url, {
//             type: 'GET',
//             dataType: 'script',
//             data: data,
//             error: function(jqXHR, textStatus, errorThrown) {
//                 return console.log("AJAX Error: " + textStatus + " " + errorThrown);
//             },
//             success: function(data, textStatus, jqXHR) {
//              return console.log("Dynamic select OK!");
//             }
//             });
//         });
// }

// $(function() {
//     var data;
//     data.area_id = $("#filterrific_with_area_id option:selected").val();
//     onChangeAjax('/common/update_zonas_filter', data);
// });
