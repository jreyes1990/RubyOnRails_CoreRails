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

  var var_dom =
    "" +
    "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
    "<'row'<'col-sm-12'tr>>" +
    "<'row'<'col-sm-10'i><'col-sm-1 text-center'><'col-sm-1'>><br>" +
    "<'row text-center' <'col-md-3'><'col-md-6'p><'col-md-3'>>";

  var var_datatable =
    "" +
    "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
    "<'row'<'col-sm-12'tr>>" +
    "<'row'<'col-sm-10'i><'col-sm-1 text-center'><'col-sm-1'>><br>" +
    "<'row text-center' <'col-md-4'><'col-md-5'p><'col-md-3'>>";

  var var_buttons = 
  [{
      text: 'CSV <i class="fas fa-file-csv"></i> ',
      extend: "csvHtml5",
      fieldSeparator: "\t",
      extension: ".csv",
      titleAttr: "Si desea exportar el archivo, Dar click en CSV",
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

  /*
  document.oncontextmenu = ev =>{
      ev.preventDefault();
  }
*/

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
    buttons: var_buttons,
    pagingType: "full_numbers",
  });

  var groupColumnAwesome = 4;
  $("#font-awesome-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumnAwesome }],
    drawCallback: function (settings) {
      var api = this.api();
      var rows = api.rows({ page: 'current' }).nodes();
      var last = null;

      api
          .column(groupColumnAwesome, { page: 'current' })
          .data()
          .each(function (group, i) {
            if (last !== group) {
              $(rows)
                  .eq(i)
                  .before('<tr class="group text-left" style="background: #ffe5a4 !important;"><td colspan="8"><strong>' + group + '</strong></td></tr>');

              last = group;
            }
          });
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    processing: true,
    serverSide: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    ajax: {
      url: $("#font-awesome-datatable").data("source"),
    },
    buttons: var_buttons,
    pagingType: "full_numbers",
    columns: [
      { data: "id", class: "text-center" },
      { data: "icono", class: "text-center" },
      { data: "prefijo_nombre" },
      { data: "codigo_css", class: "text-center" },
      { data: "tipo_icono", class: "text-center" },
      { data: "termino" },
      { data: "estado", class: "text-center" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(4).visible(false);
   
  var groupColumn = 1;
  $("#codigo-color-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      var api = this.api();
      var rows = api.rows({ page: 'current' }).nodes();
      var last = null;

      api
          .column(groupColumn, { page: 'current' })
          .data()
          .each(function (group, i) {
            if (last !== group) {
              $(rows)
                  .eq(i)
                  .before('<tr class="group text-left" style="background: #ffe5a4 !important;"><td colspan="9"><strong>' + group + '</strong></td></tr>');

              last = group;
            }
          });
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    processing: true,
    serverSide: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    ajax: {
      url: $("#codigo-color-datatable").data("source"),
    },
    buttons: var_buttons,
    pagingType: "full_numbers",
    columns: [
      { data: "id", class: "text-center" },
      { data: "disenio" },
      { data: "nombre_color" },
      { data: "colores", class: "text-center" },
      { data: "codigo_hex", class: "text-center" },
      { data: "codigo_rgb", class: "text-center" },
      { data: "codigo_hls", class: "text-center" },
      { data: "estado", class: "text-center" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(1).visible(false);

  $("#area-empresa-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      var api = this.api();
      var rows = api.rows({ page: 'current' }).nodes();
      var last = null;

      api
          .column(groupColumn, { page: 'current' })
          .data()
          .each(function (group, i) {
            if (last !== group) {
              $(rows)
                  .eq(i)
                  .before('<tr class="group text-left" style="background: #ffe5a4 !important;"><td colspan="8"><strong>' + group + '</strong></td></tr>');

              last = group;
            }
          });
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    processing: true,
    serverSide: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    ajax: {
      url: $("#area-empresa-datatable").data("source"),
    },
    buttons: var_buttons,
    pagingType: "full_numbers",
    columns: [
      { data: "id", class: "text-center" },
      { data: "nombre_empresa" },
      { data: "codigo_area", class: "text-center" },
      { data: "nombre_area" },
      { data: "codigo_hex", class: "text-center" },
      { data: "descripcion" },
      { data: "estado", class: "text-center" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(1).visible(false);

  $("#componente-datatable").DataTable({
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    processing: true,
    serverSide: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    ajax: {
      url: $("#componente-datatable").data("source"),
    },
    buttons: var_buttons,
    pagingType: "full_numbers",
    columns: [
      { data: "id", class: "text-center" },
      { data: "nombre_componente" },
      { data: "descripcion" },
      { data: "estado", class: "text-center" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  });

  $("#opcion-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      var api = this.api();
      var rows = api.rows({ page: 'current' }).nodes();
      var last = null;

      api
          .column(groupColumn, { page: 'current' })
          .data()
          .each(function (group, i) {
            if (last !== group) {
              $(rows)
                  .eq(i)
                  .before('<tr class="group text-left" style="background: #ffe5a4 !important;"><td colspan="10"><strong>' + group + '</strong></td></tr>');

              last = group;
            }
          });
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    processing: true,
    serverSide: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    ajax: {
      url: $("#opcion-datatable").data("source"),
    },
    buttons: var_buttons,
    pagingType: "full_numbers",
    columns: [
      { data: "id", class: "text-center" },
      { data: "nombre_menu" },
      { data: "icono" },
      { data: "nombre_opcion" },
      { data: "path_opcion" },
      { data: "controlador_opcion" },
      { data: "codigo_hex" },
      { data: "descripcion" },
      { data: "estado" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(1).visible(false);

  $("#menu-rol-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      var api = this.api();
      var rows = api.rows({ page: 'current' }).nodes();
      var last = null;

      api
          .column(groupColumn, { page: 'current' })
          .data()
          .each(function (group, i) {
            if (last !== group) {
              $(rows)
                  .eq(i)
                  .before('<tr class="group text-left" style="background: #ffe5a4 !important;"><td colspan="10"><strong>' + group + '</strong></td></tr>');

              last = group;
            }
          });
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    processing: true,
    serverSide: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    ajax: {
      url: $("#menu-rol-datatable").data("source"),
    },
    buttons: var_buttons,
    pagingType: "full_numbers",
    columns: [
      { data: "id", class: "text-center" },
      { data: "nombre_rol" },
      { data: "nombre_menu" },
      { data: "nombre_opcion" },
      { data: "estado" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(1).visible(false);

  $("#opcion-ca-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      var api = this.api();
      var rows = api.rows({ page: 'current' }).nodes();
      var last = null;

      api
          .column(groupColumn, { page: 'current' })
          .data()
          .each(function (group, i) {
            if (last !== group) {
              $(rows)
                  .eq(i)
                  .before('<tr class="group text-left" style="background: #ffe5a4 !important;"><td colspan="8"><strong>' + group + '</strong></td></tr>');

              last = group;
            }
          });
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    processing: true,
    serverSide: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    ajax: {
      url: $("#opcion-ca-datatable").data("source"),
    },
    buttons: var_buttons,
    pagingType: "full_numbers",
    columns: [
      { data: "id", class: "text-center" },
      { data: "nombre_menu" },
      { data: "nombre_opcion" },
      { data: "nombre_componente" },
      { data: "nombre_atributo" },
      { data: "descripcion" },
      { data: "estado" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(1).visible(false).column(2).visible(false);

  $("#personas-area-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      var api = this.api();
      var rows = api.rows({ page: 'current' }).nodes();
      var last = null;

      api
          .column(groupColumn, { page: 'current' })
          .data()
          .each(function (group, i) {
            if (last !== group) {
              $(rows)
                  .eq(i)
                  .before('<tr class="group text-left" style="background: #ffe5a4 !important;"><td colspan="8"><strong>' + group + '</strong></td></tr>');

              last = group;
            }
          });
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable,
    language: espaniol,
    processing: true,
    serverSide: true,
    lengthMenu: [
      [5, 10, 15, 20, 25, 50, -1],
      [5, 10, 15, 20, 25, 50, 'Todos'],
    ],
    ajax: {
      url: $("#personas-area-datatable").data("source"),
    },
    buttons: var_buttons,
    pagingType: "full_numbers",
    columns: [
      { data: "id", class: "text-center" },
      { data: "nombre_empresa" },
      { data: "nombre_area" },
      { data: "nombre_usuario" },
      { data: "email_usuario" },
      { data: "nombre_rol" },
      { data: "estado" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(1).visible(false).column(2).visible(false);

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

  //BUSCADOR EMPRESAS
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
