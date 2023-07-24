document.addEventListener("turbolinks:load", () => {
  /* *******************************************************
 * Configuracion para dataTables
 * *********************************************************/
  var espanol = {
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

  var var_datatable_ajax =
    "" +
    "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
    "<'row'<'col-sm-12'tr>>" +
    "<'row'<'col-md-10'i><'col-md-1 text-center'><'col-md-1'>><br>" +
    "<'row text-center' <'col-md-4'><'col-md-5'p><'col-md-3'>>";

  var var_buttons = 
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

  // Definir la función para inicializar los popovers
  function initializePopovers() {
    $('[title]').attr("data-rel", "tooltip").attr("data-placement", "top");
    var showPopover = function() {
      $(this).popover('show');
    };
    var hidePopover = function() {
      $(this).popover('hide');
    };
    $("[data-rel='tooltip']").popover({
      trigger: 'manual'
    }).click(showPopover).hover(showPopover, hidePopover);
  }

  // Función para agregar filas de agrupación en la tabla
  function addGroupRows(api, groupColumn) {
    var rows = api.rows({ page: 'current' }).nodes();
    var last = null;
    api.column(groupColumn, { page: 'current' }).data().each(function(group, i) {
      if (last !== group) {
        $(rows).eq(i).before('<tr class="group text-left" style="background: #ffe5a4 !important;"><td colspan="12"><strong>' + group + '</strong></td></tr>');
        last = group;
      }
    });
  }

  // Función para deshabilitar las últimas columnas en el DataTable
  function disableLastColumns(api, numLastColumns) {
    var totalColumns = api.columns().count(); // Obtenemos el número total de columnas en la tabla.
    var lastColumnStartIndex = totalColumns - numLastColumns; // Calculamos el índice de inicio de las últimas columnas a deshabilitar.

    api.columns().every(function (index) {
      var column = this; // Obtenemos la columna actual en la iteración.
      var isLastColumnToDisable = index >= lastColumnStartIndex; // Verificamos si la columna actual es una de las últimas columnas a deshabilitar.

      if (!isLastColumnToDisable && index !== 0 && index !== 1) {
        // Creamos el filtro de búsqueda (select) para las columnas habilitadas.
        var select = $('<select class="select2"><option value="">Busqueda....</option></select>')
          .appendTo($(column.header())) // Agregamos el filtro al encabezado de la columna.
          .on('change', function () {
            // Al cambiar el valor del filtro, realizamos una búsqueda en la columna correspondiente utilizando el método search de la API del DataTable.
            var val = $.fn.dataTable.util.escapeRegex($(this).val());
            column.search(val ? '^' + val + '$' : '', true, false).draw();
          });

        // Evitamos que el filtro y el encabezado reaccionen al clic y, por lo tanto, evitamos el ordenamiento junto con el filtro.
        $(select).click(function (e) {
          e.stopPropagation();
        });

        // Obtenemos los datos únicos de la columna y los ordenamos.
        var data = column.data().unique().sort();

        // Agregamos las opciones al filtro (select) utilizando la función $.map para crear las etiquetas <option> con los valores únicos de la columna.
        $(select).append(
          $.map(data, function (value) {
            return '<option value="' + value + '">' + value + '</option>';
          }).join('')
        );

        // Inicializamos el filtro utilizando el complemento Select2 para mejorar su aspecto y funcionalidad.
        select.select2();
      }
    });
  }

  function adjustCellContent(node, content, cellWidth) {
    var tempDiv = $("<div>")
      .css({
        position: "absolute",
        top: -9999, // Colocamos el div fuera del área visible de la página.
        left: -9999,
        width: "auto",  // Permite que el contenido determine el ancho del div temporal.
        whiteSpace: "nowrap", // Evita el salto de línea automático del contenido dentro del div.
        fontSize: node.style.fontSize,  // Copiamos la fuente y tamaño de la celda original.
        fontFamily: node.style.fontFamily,
      })
      .text(content)  // Asignamos el contenido actual a este div temporal.
      .appendTo(document.body); // Agregamos el div temporal al cuerpo del documento para que sea visible para JavaScript.

    if (tempDiv.width() > cellWidth) {
      $(node).html('<div style="white-space:normal;width:' + cellWidth + 'px">' + content + '</div>');
    }

    // Eliminamos el div temporal, ya que solo se utilizó para medir el ancho del contenido y no es necesario en la página.
    tempDiv.remove();
  }

  /* DATATABLE AJAX PARA EL MODULO DE FONT_AWESOM */
  var groupColumnAwesome = 4;
  var fontAwesomeDatatable = $("#font-awesome-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumnAwesome }],
    drawCallback: function (settings) {
      addGroupRows(this.api(), groupColumnAwesome); // Agrupación de columnas
      initializePopovers(); // Inicializar Popover después de cargar los datos
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable_ajax,
    language: espanol,
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
    autoFill: {
      enable: true, // Permite el rellenado automático de celdas en la tabla.
    },
    initComplete: initializeFontAwesomeDatatable,
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

  // Función que se ejecuta en el evento init.dt para inicializar la tabla.
  function initializeFontAwesomeDatatable() {
    var api = this.api();
    var numLastColumnsToDisable = 6;
    disableLastColumns(api, numLastColumnsToDisable);

    // Llamamos a la función adjustCellContent para ajustar el contenido de las celdas al cargar o paginar los datos.
    fontAwesomeDatatable.on("draw.dt", function () {
      fontAwesomeDatatable.cells(":visible").every(function () {
        var content = this.data();
        var cellWidth = $(this.node()).width();
        adjustCellContent(this.node(), content, cellWidth);
      });
    });

    // Inicializamos los Select2 después de deshabilitar las últimas columnas y de dibujar el DataTable.
    $(api.table().header()).find(".select2-filter").select2();
  }

  /* DATATABLE AJAX PARA EL MODULO DE COLOR */
  var groupColumn = 1;
  $("#codigo-color-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      addGroupRows(this.api(), groupColumn);  // Agrupación de columnas
      initializePopovers(); // Inicializar Popover después de cargar los datos
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable_ajax,
    language: espanol,
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

  /* DATATABLE AJAX PARA EL MODULO DE AREA */
  $("#area-empresa-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      addGroupRows(this.api(), groupColumn);  // Agrupación de columnas
      initializePopovers(); // Inicializar Popover después de cargar los datos
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable_ajax,
    language: espanol,
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
      { data: "estado", class: "text-center" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(1).visible(false);

  /* DATATABLE AJAX PARA EL MODULO DE PERSONAS AREA */
  $("#personas-area-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      addGroupRows(this.api(), groupColumn);  // Agrupación de columnas
      initializePopovers(); // Inicializar Popover después de cargar los datos
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable_ajax,
    language: espanol,
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

  /* DATATABLE AJAX PARA EL MODULO DE OPCION */
  $("#opcion-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      addGroupRows(this.api(), groupColumn);  // Agrupación de columnas
      initializePopovers(); // Inicializar Popover después de cargar los datos
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable_ajax,
    language: espanol,
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
      { data: "estado" },
      { data: "opciones", class: "text-center" },
      { data: "inactivar", class: "text-center" },
    ],
  }).column(1).visible(false);

  /* DATATABLE AJAX PARA EL MODULO DE MENU ROL */
  $("#menu-rol-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      addGroupRows(this.api(), groupColumn);  // Agrupación de columnas
      initializePopovers(); // Inicializar Popover después de cargar los datos
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable_ajax,
    language: espanol,
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

  /* DATATABLE AJAX PARA EL MODULO DE COMPONENTE */
  $("#componente-datatable").DataTable({
    drawCallback: function (settings) {
      // Inicializar Popover después de cargar los datos
      initializePopovers();
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable_ajax,
    language: espanol,
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

  /* DATATABLE AJAX PARA EL MODULO DE OPCION CA */
  $("#opcion-ca-datatable").DataTable({
    columnDefs: [{ visible: false, targets: groupColumn }],
    drawCallback: function (settings) {
      addGroupRows(this.api(), groupColumn);  // Agrupación de columnas
      initializePopovers(); // Inicializar Popover después de cargar los datos
    },
    fixedHeader: true,
    stateSave: true,
    stateDuration: 1200,
    responsive: true,
    dom: var_datatable_ajax,
    language: espanol,
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

});