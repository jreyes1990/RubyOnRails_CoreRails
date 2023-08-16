document.addEventListener("turbolinks:load", () => {
  /* *******************************************************
   * Para Configuracion para dataTables
   * *********************************************************/
  var espaniol = {
    sEmptyTable: "No has datos disponibles en la tabla.",
    sLengthMenu: "Mostrar _MENU_ registros",
    //"iDisplayLength": 5,
    sZeroRecords: "No se encontraron resultados",
    info: "Mostrando _END_ registros, de _TOTAL_ registros ",
    sEmptyTable: "Ningún dato disponible en esta tabla",
    sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
    sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
    sInfoPostFix: "",
    sProcessing: "Procesando...",
    sSearch: "",
    sUrl: "",
    sInfoThousands: ",",
    sLoadingRecords: "Cargando...",
    oPaginate: {
      sFirst: "Primero",
      sLast: "Último",
      sNext: "Siguiente",
      sPrevious: "Anterior",
    },
    aria: {
      sSortAscending: "Ordenación Ascendente",
      sSortDescending: "Ordenación Descendente",
    }
  };

  var var_datatable = 
    `<'row'<'col-md-3'l><'col-md-6 text-center'B><'col-md-3'f>>
     <'row'<'col-sm-12'tr>>
     <'row'<'col-sm-12'i>>
     <'row'<'col-sm-4'><'col-sm-4 text-center'p><'col-sm-4'>>`;

  var btnDescarga = [
    {
      text: 'EXCEL <i class="fas fa-file-excel"></i> ',
      extend: "csvHtml5",
      fieldSeparator: "\t",
      extension: ".xlsx",
      className: "btn btn-success",
      messageTop: "La exportación excel, se ha realizado correctamente",
      exportOptions: {
        columns: ":visible:not(:first-child):not(:nth-last-child(-n+2))" // Excluir el primer campo y los últimos 2 campos
        //columns: ":visible:not(:first-child):not(:nth-child(4)):not(:nth-last-child(-n+3))" // Excluir primer, cuarto y últimos 3 campos
      },
      init: function(api, node, config) {
        $(node).attr("data-custom-class", "popover-success");
        $(node).attr("title", "EXCEL");
        $(node).attr("data-content", "Si desea exportar el archivo, Dar click en EXCEL");
        // $(node).popover({
        //   html: true // Permite utilizar contenido HTML en el popover
        // });
      }
    },
    {
      text: 'PDF <i class="fas fa-file-pdf"></i> ',
      extend: "pdfHtml5",
      className: "btn btn-danger",
      messageTop: "PDF created by PDFMake with Buttons for DataTables.",
      exportOptions: {
        columns: ":visible:not(:first-child):not(:nth-last-child(-n+2))" // Excluir el primer campo y los últimos 2 campos
        //columns: ":visible:not(:first-child):not(:nth-child(4)):not(:nth-last-child(-n+3))" // Excluir primer, cuarto y últimos 3 campos
      },
      init: function(api, node, config) {
        $(node).attr("data-custom-class", "popover-danger");
        $(node).attr("title", "PDF");
        $(node).attr("data-content", "Si desea exportar el archivo, Dar click en PDF");
        // $(node).popover({
        //   html: true // Permite utilizar contenido HTML en el popover
        // });
      }
    }
  ];

  var button_datatable = 
  [{
      text: 'CSV <i class="fas fa-file-csv"></i> ',
      extend: "csvHtml5",
      fieldSeparator: "\t",
      extension: ".csv",
      className: "btn btn-warning",
      exportOptions: {
        columns: ":visible:not(:first-child):not(:nth-last-child(-n+2))" // Excluir el primer campo y los últimos 2 campos
        //columns: ":visible:not(:first-child):not(:nth-child(4)):not(:nth-last-child(-n+3))" // Excluir primer, cuarto y últimos 3 campos
      },
      init: function(api, node, config) {
        $(node).attr("data-custom-class", "popover-warning");
        $(node).attr("title", "CSV");
        $(node).attr("data-content", "Si desea exportar el archivo, Dar click en CSV");
        // $(node).popover({
        //   html: true // Permite utilizar contenido HTML en el popover
        // });
      }
    },
    {
      text: 'EXCEL <i class="fas fa-file-excel"></i> ',
      extend: "csvHtml5",
      fieldSeparator: "\t",
      extension: ".xlsx",
      className: "btn btn-success",
      messageTop: "La exportación excel, se ha realizado correctamente",
      exportOptions: {
        columns: ":visible:not(:first-child):not(:nth-last-child(-n+2))" // Excluir el primer campo y los últimos 2 campos
        //columns: ":visible:not(:first-child):not(:nth-child(4)):not(:nth-last-child(-n+3))" // Excluir primer, cuarto y últimos 3 campos
      },
      init: function(api, node, config) {
        $(node).attr("data-custom-class", "popover-success");
        $(node).attr("title", "EXCEL");
        $(node).attr("data-content", "Si desea exportar el archivo, Dar click en EXCEL");
        // $(node).popover({
        //   html: true // Permite utilizar contenido HTML en el popover
        // });
      }
    },
    {
      text: 'PDF <i class="fas fa-file-pdf"></i> ',
      extend: "pdfHtml5",
      className: "btn btn-danger",
      messageTop: "PDF created by PDFMake with Buttons for DataTables.",
      exportOptions: {
        columns: ":visible:not(:first-child):not(:nth-last-child(-n+2))" // Excluir el primer campo y los últimos 2 campos
        //columns: ":visible:not(:first-child):not(:nth-child(4)):not(:nth-last-child(-n+3))" // Excluir primer, cuarto y últimos 3 campos
      },
      init: function(api, node, config) {
        $(node).attr("data-custom-class", "popover-danger");
        $(node).attr("title", "PDF");
        $(node).attr("data-content", "Si desea exportar el archivo, Dar click en PDF");
        // $(node).popover({
        //   html: true // Permite utilizar contenido HTML en el popover
        // });
      }
    },
    {
      text: 'PRINT <i class="fas fa-print"></i> ',
      extend: "print",
      className: "btn btn-info",
      exportOptions: {
        columns: ":visible:not(:first-child):not(:nth-last-child(-n+2))" // Excluir el primer campo y los últimos 2 campos
        //columns: ":visible:not(:first-child):not(:nth-child(4)):not(:nth-last-child(-n+3))" // Excluir primer, cuarto y últimos 3 campos
      },
      init: function(api, node, config) {
        $(node).attr("data-custom-class", "popover-info");
        $(node).attr("title", "PRINT");
        $(node).attr("data-content", "Si desea imprimr, Dar click en PRINT");
        // $(node).popover({
        //   html: true // Permite utilizar contenido HTML en el popover
        // });
      }
    },
    {
      text: "JSON",
      className: "btn btn-secondary",
      exportOptions: {
        columns: ":visible:not(:first-child):not(:nth-last-child(-n+2))" // Excluir el primer campo y los últimos 2 campos
        //columns: ":visible:not(:first-child):not(:nth-child(4)):not(:nth-last-child(-n+3))" // Excluir primer, cuarto y últimos 3 campos
      },
      action: function (e, dt, button, config) {
        var data = dt.buttons.exportData();

        $.fn.dataTable.fileSave(
          new Blob([JSON.stringify(data)]),
          "Export.json"
        );
      },
      init: function(api, node, config) {
        $(node).attr("data-custom-class", "popover-secondary");
        $(node).attr("title", "JSON");
        $(node).attr("data-content", "Si desea exportar el archivo, Dar click en JSON");
        // $(node).popover({
        //   html: true // Permite utilizar contenido HTML en el popover
        // });
      }
  }];

  $(document).ajaxSend(function (e, xhr, options) {
    var token = $("meta[name='csrf-token']").attr("content");
    xhr.setRequestHeader("X-CSRF-Token", token);
  });
  /* *******************************************************
   * Fin de Configuracion para dataTables
   * *********************************************************/
  
  function searchColumnsSelect(api, searchableColumns) {
    api.columns().every(function (index) {
      var column = this;
      var isSearchable = searchableColumns.includes(index);

      if (isSearchable) {
        var select = $('<select class="select2"><option value="">Busqueda....</option></select>')
          .appendTo($(column.header()))
          .on('change', function () {
            var val = $.fn.dataTable.util.escapeRegex($(this).val());
            column.search(val ? '^' + val + '$' : '', true, false).draw();
          });

        $(select).click(function (e) {
          e.stopPropagation();
        });

        var data = column.data().unique().sort();

        $(select).append(
          $.map(data, function (value) {
            return '<option value="' + value + '">' + value + '</option>';
          }).join('')
        );

        select.select2();
        var headerWidth = $(column.header()).width();
        $(select).css('width', headerWidth);
      }
    });
  }
  
  //configuracion para datatables agrupados por columnas dinamico
  /**
  * Función para agrupar filas en un DataTable en base a múltiples columnas.
  * @param {string} var_dom - Selector o elemento DOM donde se mostrará el DataTable. Por ejemplo, '#datatable_familia_producto' o document.getElementById('datatable_familia_producto').
  * @param {Array} agrupaciones - Un array que contiene objetos con detalles de las columnas que se utilizarán para la agrupación. Cada objeto debe tener la forma { columnIndex: number, label: string }, donde columnIndex es el índice de la columna (comenzando desde 0) y label es el nombre o etiqueta de la columna que se utilizará para mostrar el nombre del grupo.
  * @param {Array|null} columnDefs - Un array opcional que contiene configuraciones adicionales para las columnas del DataTable, en el formato requerido por DataTables columnDefs. Puede ser nulo si no se necesita ninguna configuración adicional.
  * @param {Object} options - Opciones adicionales para configurar el DataTable, siguiendo el formato de configuración del DataTable. Puedes personalizar opciones como el orden, dom, lenguaje, botones, etc.
  * @param {Array} searchColumns - Un array con los índices de las columnas en las que se aplicará la búsqueda selectiva.
  * @param {string} tipoPagina - Tipo de paginación para el DataTable.
  */
  function agrupar_filas(var_dom, agrupaciones, columnDefs, options, searchColumns, tipoPagina) {
    // Comprueba si agrupaciones está vacío
    if (!agrupaciones || agrupaciones.length === 0) {
      // Aquí puedes inicializar la tabla sin el rowGroup, si lo deseas
      $(var_dom).DataTable({
        "columnDefs": columnDefs || [],
        fixedHeader: options.fixedHeader,
        stateSave: options.stateSave,
        stateDuration: options.stateDuration,
        dom: options.dom,
        language: options.language,
        responsive: options.responsive,
        lengthChange: options.lengthChange,
        lengthMenu: options.lengthMenu,
        select: options.select,
        buttons: options.buttons,
        initComplete: function () {
          var api = this.api();
          searchColumnsSelect(api, searchColumns); // Llamada a la función para aplicar búsqueda selectiva en las columnas especificadas
        },
        pagingType: tipoPagina
      });

      return;
    }

    var dataSrc = agrupaciones.map(agrupacion => agrupacion.columnIndex);
    var orden = agrupaciones.length > 1 ? agrupaciones.map(agrupacion => [agrupacion.columnIndex, agrupacion.order || 'asc']) : [];

    $(var_dom).DataTable({
      "order": orden,
      "columnDefs": [...agrupaciones.map(agrupacion => ({ "visible": false, "targets": agrupacion.columnIndex })), ...(columnDefs ?? [])],
      rowGroup: {
        dataSrc: dataSrc,
        startRender: function (rows, group, level) {
          var className = '';
          var groupName = '';

          agrupaciones.forEach((agrupacion, index) => {
            if (level === index) {
              className = `group-start-level-${index}`;
              groupName = `${agrupacion.label}: ${group}`;
            }
          });

          return $('<tr/>').append(`<td colspan="20"> ${groupName} </td>`).addClass(className);
        }
      },
      fixedHeader: options.fixedHeader,
      stateSave: options.stateSave,
      stateDuration: options.stateDuration,
      dom: options.dom,
      language: options.language,
      responsive: options.responsive,
      lengthChange: options.lengthChange,
      lengthMenu: options.lengthMenu,
      select: options.select,
      buttons: options.buttons,
      initComplete: function () {
        var api = this.api();
        searchColumnsSelect(api, searchColumns);
      },
      pagingType: tipoPagina
    });
  }

  //opciones que se pueden utilizar en el datatable - estas son estandar
  var opciones = {
    fixedHeader: true,            // Encabezado fijo al hacer scroll.
    stateSave: true,              // Guarda el estado actual de la tabla para recordar las configuraciones personalizadas del usuario.
    stateDuration: 1200,          // Tiempo en milisegundos que se guarda el estado de la tabla en el almacenamiento local.
    dom: var_datatable,           // Define la disposición personalizada de los elementos del DataTable (pueden incluir botones, filtros, etc.).
    language: espaniol,           // Configura el idioma de la tabla, en este caso, español.
    responsive: true,             // Permite que la tabla se adapte y sea responsive en diferentes dispositivos.
    lengthChange: true,           // Permite al usuario cambiar la cantidad de registros mostrados por página.
    lengthMenu: [
      // Define las opciones de cantidad de registros por página en el menú desplegable.
      [5, 10, 15, 20, 25, 50, -1],      // Opciones de cantidad de registros.
      [5, 10, 15, 20, 25, 50, 'Todos'], // Etiquetas que se muestran en el menú desplegable.
    ],
    select: true,                 // Permite la selección de filas en la tabla.
    buttons: button_datatable,    // Define los botones personalizados que se agregarán a la tabla.
    initComplete: true,
    pagingType: true              // Tipo de paginación, muestra todos los controles disponibles (primero, último, siguiente, anterior, etc.).
  };

  agrupar_filas(
    '#datatable_usuario',
    [],
    [
      { responsivePriority: 1, targets: [0, 1, -1] },
      { responsivePriority: 2, targets: [2, -2] },
      { responsivePriority: 3, targets: [3, 4] }
    ],
    opciones,
    [1, 2],
    "full_numbers"
  )

  agrupar_filas(
    '#datatable_empresa',
    [],
    [
      { responsivePriority: 1, targets: [1, -1, -2] },
      { responsivePriority: 2, targets: [2, -3] },
      { responsivePriority: 3, targets: [0, 3, 4] }
    ],
    opciones,
    [1, 2],
    "full_numbers"
  )

  agrupar_filas(
    '#datatable_rol',
    [],
    [
      { responsivePriority: 1, targets: [1, -1, -2] },
      { responsivePriority: 2, targets: [0, -3] },
      { responsivePriority: 3, targets: [2, 3] }
    ],
    opciones,
    [1],
    "full_numbers"
  )

  agrupar_filas(
    '#datatable_menu',
    [],
    [
      { responsivePriority: 1, targets: [2, -1, -2] },
      { responsivePriority: 2, targets: [1, -3] },
      { responsivePriority: 3, targets: [0, 3, 4] }
    ],
    opciones,
    [2],
    "full_numbers"
  )

  agrupar_filas(
    '#datatable_atributo',
    [],
    [
      { responsivePriority: 1, targets: [1, -1, -2] },
      { responsivePriority: 2, targets: [0, -3] },
      { responsivePriority: 3, targets: [2] }
    ],
    opciones,
    [1],
    "full_numbers"
  )

});