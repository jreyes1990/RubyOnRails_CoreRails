document.addEventListener("turbolinks:load", () => {
  $('.add_permisos_perfil_id').hide();
  $('.add_permisos_opcion_id').hide();

  $('[name="add_permisos[options]"]').on('change', function () {
    if ($(this).val() == '0') {
      $('.add_permisos_perfil_id').show();
      $('.add_permisos_opcion_id').hide();
      $('#add_permisos_perfil_id').attr("required", true);
      $('#add_permisos_opcion_id').removeAttr('required');
    }else {
      $('.add_permisos_perfil_id').hide();
      $('.add_permisos_opcion_id').show();
      $('#add_permisos_perfil_id').removeAttr('required');
      $('#add_permisos_opcion_id').attr("required", true);
    }
  });
  
  //funcion para seleccionar los permisos por perfil
  $('.select2-perfil').on('select2:select', function (e) {
    $.ajax({
      url: $('.path_opciones_perfil').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        role_id_params: e.params.data.id
      },
      success: function (data) {
        if (data.response == '1') {
          $('#rowFormularios').html(data.data);
          $('#divOpciones').show();
        } else {
          $('#rowFormularios').html("");
          $('#divOpciones').hide();
        }
      }
    });
  });

  //funcion para seleccionar los permisos individualmente
  $('.select2-individual').on('select2:select', function (e) {
    $.ajax({
      url: $('.path_opciones_individual').data('endpoint'),
      type: 'GET',
      dataType: "json",
      data: {
        opcion_id_params: e.params.data.id
      },
      success: function (data) {
        if (data.response == '1') {
          $('#rowFormularios').html(data.data);
          $('#divOpciones').show();
        } else {
          $('#rowFormularios').html("");
          $('#divOpciones').hide();
        }
      }
    });
  });

});