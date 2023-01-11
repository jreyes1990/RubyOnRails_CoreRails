// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

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
import "startbootstrap-sb-admin-2/js/sb-admin-2";
import "startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.bundle";
import "startbootstrap-sb-admin-2/vendor/jquery-easing/jquery.easing";
import "startbootstrap-sb-admin-2/vendor/fontawesome-free/js/all";

import "datatables.net/js/jquery.dataTables";

import "datatables.net-bs4/js/dataTables.bootstrap4";

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

let pdfMake = require("pdfmake/build/pdfmake");
let pdfFonts = require("pdfmake/build/vfs_fonts");
pdfMake.vfs = pdfFonts.pdfMake.vfs;

import "controllers"

document.addEventListener("turbolinks:load", () => {
    /* *******************************************************
   * Configuracion para dataTables
   * *********************************************************/
    var espaniol = {
        sEmptyTable: "No has datos disponibles en la tabla.",
        sLengthMenu: "Mostrar _MENU_ Entradas",
        //"LengthMenu": [[5,10,15,20,25,50,-1],[5,10,15,20,25,50,"Todos"]],
        //"iDisplayLength": 5,
        sZeroRecords: "No se encontraron resultados",
        info: "Mostrando _END_ registros, de _TOTAL_ registros",
        sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
        sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
        sInfoPostFix: "(Actualizados)",
        sProcessing: "Procesando...",
        sSearch: "Buscar",
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
        "<'row'<'col-sm-5'i><'col-sm-3 text-center'p><'col-sm-4'>>";

    $(document).ajaxSend(function (e, xhr, options) {
        var token = $("meta[name='csrf-token']").attr("content");
        xhr.setRequestHeader("X-CSRF-Token", token);
    });

    $("#datatable").DataTable({
        fixedHeader: true,
        stateSave: true,
        stateDuration: 1200,
        responsive: "true",
        dom: var_dom,
        language: espaniol,
        lengthChange: true,
        select: true,
        order: [0, "desc"],
        buttons: [
            {
                text: 'CSV <i class="fas fa-file-csv"></i> ',
                extend: "csvHtml5",
                fieldSeparator: "\t",
                extension: ".csv",
                titleAttr: "Si desea exportar el archivo, Dar click en CSV",
                className: "btn btn-outline-warning",
            },
            {
                text: 'EXCEL <i class="fas fa-file-excel"></i> ',
                extend: "csvHtml5",
                fieldSeparator: "\t",
                extension: ".xlsx",
                titleAttr: "Si desea exportar el archivo, Dar click en EXCEL",
                className: "btn btn-outline-success",
                messageTop: "La exportación excel, se ha realizado correctamente",
            },
            {
                text: 'PDF <i class="fas fa-file-pdf"></i> ',
                extend: "pdfHtml5",
                titleAttr: "Si desea exportar el archivo, Dar click en PDF",
                className: "btn btn-outline-danger",
                messageTop: "PDF created by PDFMake with Buttons for DataTables.",
            },
            {
                text: 'PRINT <i class="fas fa-print"></i> ',
                extend: "print",
                titleAttr: "Si desea imprimr, Dar click en PRINT",
                className: "btn btn-outline-info",
                exportOptions: {
                    columns: ":visible",
                },
            },
            {
                text: "JSON",
                titleAttr: "Si desea exportar el archivo, Dar click en JSON",
                className: "btn btn-outline-primary",
                action: function (e, dt, button, config) {
                    var data = dt.buttons.exportData();

                    $.fn.dataTable.fileSave(
                        new Blob([JSON.stringify(data)]),
                        "Export.json"
                    );
                },
            },
        ],
        pagingType: "full_numbers",
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

    $("#opcion-ca-datatable").DataTable({
        fixedHeader: true,
        stateSave: true,
        stateDuration: 1200,
        responsive: "true",
        dom: var_dom,
        language: espaniol,
        processing: true,
        serverSide: true,
        ajax: {
            url: $("#opcion-ca-datatable").data("source"),
        },
        order: [0, "desc"],
        buttons: [
            {
                text: 'CSV <i class="fas fa-file-csv"></i> ',
                extend: "csvHtml5",
                fieldSeparator: "\t",
                extension: ".csv",
                titleAttr: "Si desea exportar el archivo, Dar click en CSV",
                className: "btn btn-outline-warning",
            },
            {
                text: 'EXCEL <i class="fas fa-file-excel"></i> ',
                extend: "csvHtml5",
                fieldSeparator: "\t",
                extension: ".xlsx",
                titleAttr: "Si desea exportar el archivo, Dar click en EXCEL",
                className: "btn btn-outline-success",
                messageTop: "La exportación excel, se ha realizado correctamente",
            },
            {
                text: 'PDF <i class="fas fa-file-pdf"></i> ',
                extend: "pdfHtml5",
                titleAttr: "Si desea exportar el archivo, Dar click en PDF",
                className: "btn btn-outline-danger",
                messageTop: "PDF created by PDFMake with Buttons for DataTables.",
            },
            {
                text: 'PRINT <i class="fas fa-print"></i> ',
                extend: "print",
                titleAttr: "Si desea imprimr, Dar click en PRINT",
                className: "btn btn-outline-info",
                exportOptions: {
                    columns: ":visible",
                },
            },
            {
                text: "JSON",
                titleAttr: "Si desea exportar el archivo, Dar click en JSON",
                className: "btn btn-outline-primary",
                action: function (e, dt, button, config) {
                    var data = dt.buttons.exportData();

                    $.fn.dataTable.fileSave(
                        new Blob([JSON.stringify(data)]),
                        "Export.json"
                    );
                },
            },
        ],
        pagingType: "full_numbers",
        columns: [
            { data: "id" },
            { data: "opcion" },
            { data: "componente" },
            { data: "atributo" },
            { data: "descripcion" },
            { data: "estado" },
            { data: "editar" },
            { data: "inactivar" },
        ],
    });

});


