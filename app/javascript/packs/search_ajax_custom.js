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

});