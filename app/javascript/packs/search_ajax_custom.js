document.addEventListener("turbolinks:load", () => {
  //BUSCADOR AREAS POR EMPRESA
  $('#codigo_empresa_persona').select2({
    ajax: {
      url: $('#codigo_empresa_persona').data('endpoint'),
      dataType: "json",
      delay: 500,
      data: function (params) {
        return {
          empresa_usuario_area_params: params.term, // search term
          page: params.page
        };
      },
      processResults: function (data, page) {
        return {
          //results: data
          results: $.map(data, function (value, index) {
            return {
              id: value.valor_id,
              text: value.valor_text
            };
          })
        };
      }
    },
    minimumInputLength: 2,
    theme: "bootstrap4",
    language: "es-GT",
    width: '100%'
  });

  // BUSCADOR AREA - EMPRESA, EN EL MODULO PERSONAS AREA
  $('#codigo_empresa_persona').on('select2:select', function (e) {
    $.ajax({
      url: $('.area_persona').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        personas_area_params: e.params.data.id
      },
      success: function (data) {
        $("#codigo_area_persona").empty();

        var json = data;
        $("#codigo_area_persona").append("<option value='" + 0 + "'>Seleccione una área</option>");
        for (var i of json) {
          $("#codigo_area_persona").append("<option value='" + i.valor_id + "'>" + i.valor_text + "</option>");
        }
      }
    });
  });

});