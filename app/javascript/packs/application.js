// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import { auto } from "@popperjs/core";

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "startbootstrap-sb-admin-2/vendor/jquery/jquery";
import "@popperjs/core/dist/umd/popper";
import "startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.bundle";
import "startbootstrap-sb-admin-2/vendor/jquery-easing/jquery.easing";
import "startbootstrap-sb-admin-2/js/sb-admin-2";
import "startbootstrap-sb-admin-2/vendor/fontawesome-free/js/all";

import "datatables.net/js/jquery.dataTables";

import "datatables.net-bs/js/dataTables.bootstrap";

import "datatables.net-buttons-bs4/js/buttons.bootstrap4";

import "datatables.net-buttons/js/dataTables.buttons";
import "datatables.net-buttons/js/buttons.flash";
import "datatables.net-buttons/js/buttons.colVis";
import "datatables.net-buttons/js/buttons.html5";
import "datatables.net-buttons/js/buttons.print";

import "pdfmake/build/pdfmake";
import "pdfmake/build/vfs_fonts";
import "jszip/dist/jszip";

import "select2/dist/js/select2";
import "select2/dist/js/i18n/es";

import "datatables.net-responsive/js/dataTables.responsive";
import "datatables.net-responsive-bs4/js/responsive.bootstrap4";

import "moment/dist/moment";
import "moment/dist/locale/es";

import "controllers"

import "trix";
import "@rails/actiontext";

var jQuery = require("jquery");

// import jQuery from "jquery";
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;


let pdfMake = require("pdfmake/build/pdfmake");
let pdfFonts = require("pdfmake/build/vfs_fonts");
pdfMake.vfs = pdfFonts.pdfMake.vfs;

import "./custom_datatable_ajax";
import "./custom_search_ajax";
import "./custom_wizard_form";

document.addEventListener("turbolinks:load", () => {
  /* *******************************************************
 * Configuracion para dataTables
 * *********************************************************/
  var espaniol = {
    sEmptyTable: "No has datos disponibles en la tabla.",
    sLengthMenu: "Mostrar _MENU_ Entradas",
    //"iDisplayLength": 5,
    sZeroRecords: "No se encontraron resultados",
    info: "Mostrando _END_ registros, de _TOTAL_ registros ",
    sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
    sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
    sInfoPostFix: "(Actualizados)",
    sProcessing: "Procesando...",
    sSearch: "",
    oPaginate: {
      sFirst: "Primero",
      sLast: "Último",
      sNext: "Siguiente",
      sPrevious: "Anterior",
    },
    aria: {
      sSortAscending: "Ordenación Ascendente",
      sSortDescending: "Ordenación Descendente",
    },
  };

  var var_datatable =
    "" +
    "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
    "<'row'<'col-sm-12'tr>>" +
    "<'row'<'col-md-10'i><'col-md-1 text-center'><'col-md-1'>><br>" +
    "<'row text-center' <'col-md-4'><'col-md-5'p><'col-md-3'>>";

  var button_datatable = 
  [{
      text: 'CSV <i class="fas fa-file-csv"></i> ',
      extend: "csvHtml5",
      fieldSeparator: "\t",
      extension: ".csv",
      dataContentAttr: "Si desea exportar el archivo, Dar click en CSV",
      titleAttr: 'Si desea exportar el archivo, Dar click en CSV',
      customClassName: "popover-success",
      className: "btn btn-warning",
    },
    {
      text: 'EXCEL <i class="fas fa-file-excel"></i> ',
      extend: "csvHtml5",
      fieldSeparator: "\t",
      extension: ".xlsx",
      titleAttr: "Si desea exportar el archivo, Dar click en EXCEL",
      className: "btn btn-success",
      messageTop: "La exportación excel, se ha realizado correctamente",
    },
    {
      text: 'PDF <i class="fas fa-file-pdf"></i> ',
      extend: "pdfHtml5",
      titleAttr: "Si desea exportar el archivo, Dar click en PDF",
      className: "btn btn-danger",
      messageTop: "PDF created by PDFMake with Buttons for DataTables.",
    },
    {
      text: 'PRINT <i class="fas fa-print"></i> ',
      extend: "print",
      titleAttr: "Si desea imprimr, Dar click en PRINT",
      className: "btn btn-info",
      exportOptions: {
        columns: ":visible",
      },
    },
    {
      text: "JSON",
      titleAttr: "Si desea exportar el archivo, Dar click en JSON",
      className: "btn btn-primary",
      action: function (e, dt, button, config) {
        var data = dt.buttons.exportData();

        $.fn.dataTable.fileSave(
          new Blob([JSON.stringify(data)]),
          "Export.json"
        );
      },
  }];

  $(document).ajaxSend(function (e, xhr, options) {
    var token = $("meta[name='csrf-token']").attr("content");
    xhr.setRequestHeader("X-CSRF-Token", token);
  });

  /* *******************************************************
   * Para controlar el sidebar en posición cerrado o abierto
   * ******************************************************** */
  let sidebarState = sessionStorage.getItem("sidebar");
  $(".sidebar").toggleClass(sidebarState);

  $("#sidebarToggle, #sidebarToggleTop").on('click', function (e) {
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
    if ($(".sidebar").hasClass("toggled")) {
      sessionStorage.setItem("sidebar", "toggled");
      $('.sidebar .collapse').collapse('hide');
    } else {
      sessionStorage.setItem("sidebar", "");
    }
  });

  if (sidebarState === "toggled") {
    $(".menu_sb").addClass("collapsed");
    $(".opcion_sb").removeClass("show");
  }
  
  $("#topBtn").click(function () {
    $("html ,body").animate(
      {
        scrollTop: 0,
      },
      800
    );
  });
  /* *******************************************************
   * Fin para controlar el sidebar en posición cerrado o abierto
   * ******************************************************** */

  //control de los tiempos de los flash
  $(".alert")
    .fadeTo(4000, 500)
    .slideUp(500, function () {
      $(".alert").slideUp(4000);
    });

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

  const originalWebSocketClose = WebSocket.prototype.close
  WebSocket.prototype.close = function () {
    if (this.readyState != WebSocket.CONNECTING) {
      originalWebSocketClose.apply(this, arguments)
    }
  }

  // Configuracion para activar select2
  $(".select2").select2({
    theme: "bootstrap4",
    language: "es-GT",
    width: "100%",
  });

  // Configuracion para activar select2 multiple
  $(".select2-multiple").select2({
    language: "es-GT",
    width: "100%",
  });

  //
  //funcion para los mensajes de los toggle en las tablas
  $(function() {
    $('[title]').attr("data-rel", "tooltip");
    $("[data-rel='tooltip']")
        .attr("data-placement", "top");

    var showPopover = function() {
        $(this).popover('show');
    };
    var hidePopover = function() {
        $(this).popover('hide');
    };
    $("[data-rel='tooltip']").popover({
        trigger: 'manual'
    }).click(showPopover).hover(showPopover, hidePopover);
  });

  $("#datatable").DataTable({
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    lengthChange: true,
    select: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    buttons: button_datatable,
    pagingType: "full_numbers",
  });

  //BUSCADOR EMPRESAS
  $('#codigo_empresa_usuario').select2({
    ajax: {
      url: $('#codigo_empresa_usuario').data('endpoint'),
      dataType: "json",
      delay: 500,
      data: function (params) {
        return {
          empresa_usuario_params: params.term, // search term
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

  $(".custom-file-input").on("change", function () {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
  });
  
});
