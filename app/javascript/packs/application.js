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

import "bootstrap-toggle/js/bootstrap-toggle";

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

import "./custom_show_hidden_password";
import "./custom_datatable";
import "./custom_datatable_ajax";
import "./custom_search_ajax";
import "./custom_wizard_form";

document.addEventListener("turbolinks:load", () => {
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

  const originalWebSocketClose = WebSocket.prototype.close
  WebSocket.prototype.close = function () {
    if (this.readyState != WebSocket.CONNECTING) {
      originalWebSocketClose.apply(this, arguments)
    }
  }
  /* *******************************************************
   * Fin para controlar el sidebar en posición cerrado o abierto
   * ******************************************************** */

  // control de los tiempos de los flash
  $(".alert")
    .fadeTo(4000, 500)
    .slideUp(500, function () {
      $(".alert").slideUp(4000);
  });
  // Fin del control de los tiempos de los flash

  // funcion para los mensajes de los toggle en las tablas
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
  // Fin de la funcion para los mensajes de los toggle en las tablas

  // Uso para la visualizacion del archivo que se esta cargando de file_input
  $(".custom-file-input").on("change", function () {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
  });
  // Fin del Uso para la visualizacion del archivo que se esta cargando de file_input
  
  // Inicializar el interruptor de cambio
  $(document).ready(function() {
    $('#my-toggle, #correo_usuario, #telegram_usuario').bootstrapToggle({
      on: 'Si',
      off: 'No',
      style: 'ios'
    });
  });
  // Fin de Inicializar el interruptor de cambio

  // Configuracion para activar select2
  $("#codigo_empresa_persona, #codigo_empresa_usuario, #empresa_id_area, #usuario_id_persona").select2({
    minimumInputLength: 2,
    theme: "bootstrap4",
    language: "es-GT",
    width: "100%",
  });

  // Configuracion para activar select2
  $(".select2-search").select2({
    minimumInputLength: 2,
    theme: "bootstrap4",
    language: "es-GT",
    width: "100%",
  });

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
      },
      minimumInputLength: 2,
      theme: "bootstrap4",
      language: "es-GT",
      width: '100%'
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


});
