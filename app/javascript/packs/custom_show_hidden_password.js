document.addEventListener("turbolinks:load", () => {
  //MOSTRAR U OCULTAR CONTRASEÑA INICIO DE SESIÓN
  $('#show_password').on('click', function (e) {
    var cambio = document.getElementById("txtPassword");
    if(cambio.type == "password"){
        cambio.type = "text";
        $('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');
    }else{
        cambio.type = "password";
        $('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');
    }
    $('#Password').attr('type', $(this).is(':checked') ? 'text' : 'password');
  });

  //MOSTRAR U OCULTAR CONTRASEÑA NUEVO REGISTRO USUARIO
  $('#nuevo_password').on('click', function (e) {
    var cambio = document.getElementById("txtNuevoPassword");
    if(cambio.type == "password"){
        cambio.type = "text";
        $('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');
    }else{
        cambio.type = "password";
        $('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');
    }
    $('#Password').attr('type', $(this).is(':checked') ? 'text' : 'password');
  });

  //MOSTRAR U OCULTAR CONFIRMACION CONTRASEÑA NUEVO REGISTRO USUARIO
  $('#confirma_nuevo_password').on('click', function (e) {
    var cambio = document.getElementById("txtConfirmaPassword");
    if(cambio.type == "password"){
        cambio.type = "text";
        $('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');
    }else{
        cambio.type = "password";
        $('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');
    }
    $('#Password').attr('type', $(this).is(':checked') ? 'text' : 'password');
  });

  $(document).ready(function () {
    $('#show_password_new').click(function () {
      var tipo = document.getElementById("txtPasswordNew");

      if(tipo.type == "password"){
        $('#txtPasswordNew').attr('type', 'text');
        $('#mostrar').addClass('fa fa-eye').removeClass('fa fa-eye-slash');
      }else{
        $('#txtPasswordNew').attr('type', 'password');
        $('#mostrar').addClass('fa fa-eye-slash').removeClass('fa fa-eye');
      }
    });
  });
  
});