document.addEventListener("turbolinks:load", () => {
  /**
   * Función para inicializar los select2 con ajax
   * @param {string} selector - Selector del elemento select2, ejemplo: "#empresa_id_estado_x_proceso"
   * @param {string} search_param - Nombre del parámetro de búsqueda para el endpoint
   * @param {string} ajax_param - Nombre del parámetro de búsqueda para el endpoint de la segunda llamada
   * @param {function} success_callback - Función que se ejecuta cuando la segunda llamada es exitosa
   * @param {function} clear_callback - Función que se ejecuta cuando la segunda llamada no es exitosa
   * @param {function} post_select_callback - Función que se ejecuta después de seleccionar un elemento del select2, puede ir null (opcional)
   */

  function initializeSelect2(selector, search_param, ajax_param, success_callback, clear_callback, post_select_callback = null) {
    // Configuración del select2 con AJAX
    $(selector).select2({
      ajax: {
        url: $(selector).data('endpoint'), // URL del endpoint para la búsqueda AJAX
        dataType: "json",
        delay: 500,
        data: function (params) {
          let search_obj = {};
          search_obj[search_param] = params.term; // Parámetro de búsqueda con el término ingresado en el select2
          return search_obj;
        },
        processResults: function (data, page) {
          return {
            results: $.map(data, function (value, index) {
              return {
                id: value.valor_id,
                text: value.valor_text
              };
            })
          };
        }
      }
    }).on('select2:select', function (e) {
      var selectedOption = e.params.data.id;
      if (selectedOption !== '') {
        if (post_select_callback) {
          post_select_callback(selectedOption);
        }
        let ajax_data = {};
        ajax_data[ajax_param] = selectedOption; // Parámetro de búsqueda para la segunda llamada AJAX
        $.ajax({
          url: $(this).data('endpoint'), // URL del endpoint para la segunda llamada AJAX
          dataType: "json",
          data: ajax_data,
          success: success_callback // Función a ejecutar cuando la segunda llamada es exitosa
        });
      } else {
        clear_callback(); // Función a ejecutar cuando no hay una opción seleccionada
      }
    });
  }

  /* BUSCADOR AREA - EMPRESA, EN EL MODULO USUARIO */
  initializeSelect2(
      "#empresa_id_usuario",
      "search_empresa_usuario_params",
      "empresa_usuario_params",
    function (data) {
      $("#area_id_usuario").empty();
      $("#area_id_usuario").append("<option value='" + 0 + "'>Seleccione una área</option>");
      for (var i of data.area_empresa) {
          $("#area_id_usuario").append("<option value='" + i.valor_id + "'>" + i.valor_text + "</option>");
      }
    },
    function () {
      $("#area_id_usuario").empty().trigger('change');
    }
  )

  /* BUSCADOR AREA - EMPRESA, EN EL MODULO PERSONAS AREA */
  initializeSelect2(
      "#empresa_id_persona",
      "search_empresa_persona_params",
      "empresa_persona_params",
    function (data) {
      $("#area_id_persona").empty();
      $("#area_id_persona").append("<option value='" + 0 + "'>Seleccione una área</option>");
      for (var i of data.persona_area_empresa) {
          $("#area_id_persona").append("<option value='" + i.valor_id + "'>" + i.valor_text + "</option>");
      }
    },
    function () {
      $("#area_id_persona").empty().trigger('change');
    }
  )

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
          console.log(`Mostrando valores ${i.opcion_id}`)
        }
      }
    });
  });

});