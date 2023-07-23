document.addEventListener("turbolinks:load", () => {
  // BUSCADOR OPCIONES, EN EL MODULO MENU ROL
  $('#codigo_menu').on('select2:select', function (e) {
    $.ajax({
      url: $('.opciones').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
          opcion_id_param: e.params.data.id
      },
      success: function (data) {
        $("#codigo_opcion").empty();

        var json = data;
        $("#codigo_opcion").append("<option value='" + 0 + "'>Seleccione una Opción</option>");
        for (var i of json) {
          $("#codigo_opcion").append("<option value='" + i.opcion_id + "'>" + i.descripcion + "</option>");
        }
      }
    });
  });

});