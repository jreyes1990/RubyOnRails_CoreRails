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
   * Fin de Configuracion para dataTables
   * *********************************************************/
  
  // Definimos la función disableLastColumns que deshabilitará las últimas columnas
  // y dejará la primera columna intacta.
  function disableLastColumns(api, numLastColumns) {
    var totalColumns = api.columns().count(); // Obtenemos el número total de columnas en la tabla.
    var lastColumnStartIndex = totalColumns - numLastColumns; // Calculamos el índice de inicio de las últimas columnas a deshabilitar.

    // Recorremos todas las columnas utilizando el método every de la API del DataTable.
    api.columns().every(function (index) {
      var column = this;  // Obtenemos la columna actual en la iteración.
      var isLastColumnToDisable = index >= lastColumnStartIndex;  // Verificamos si la columna actual es una de las últimas columnas a deshabilitar.

      if (!isLastColumnToDisable && index !== 0) {  // Comprobamos que la columna no es una de las últimas columnas a deshabilitar (index !== 0 evita la primera columna).
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

        // Ajustamos el ancho del filtro (select) basado en el ancho del texto de la descripción de la columna (headerText).
        // Esto se hace para que el filtro tenga el mismo ancho que el encabezado de la columna.
        var headerText = $(column.header()).text();
        var headerWidth = $(column.header()).width();
        $(select).css('width', headerWidth);
      }
    });
  }

  // La función adjustCellContent ajusta el contenido de la celda para que quepa dentro del ancho de la columna.
  // Recibe tres parámetros:
  // 1. node: El nodo HTML de la celda que se va a ajustar.
  // 2. content: El contenido actual de la celda.
  // 3. cellWidth: El ancho de la columna donde se encuentra la celda.
  function adjustCellContent(node, content, cellWidth) {
    // Creamos un elemento div temporal para medir el ancho del contenido de la celda sin que sea visible en la página.
    // Establecemos algunas propiedades CSS para que el div sea invisible y no afecte el diseño.
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

    // Comparamos el ancho del contenido dentro del div temporal con el ancho de la celda.
    // Si el ancho del contenido es mayor que el ancho de la celda, significa que no cabe completamente.
    if (tempDiv.width() > cellWidth) {
      // Si el contenido no cabe, ajustamos el contenido de la celda para que se muestre correctamente sin exceder el ancho de la columna.
      // Utilizamos la función html() de jQuery para establecer el contenido de la celda.
      // Agregamos un div adicional dentro de la celda con un estilo que permita el salto de línea para mostrar el contenido completo.
      // Limitamos el ancho del div adicional al ancho de la columna para evitar que se desborde.
      $(node).html('<div style="white-space:normal;width:' + cellWidth + 'px">' + content + '</div>');
    }

    // Eliminamos el div temporal, ya que solo se utilizó para medir el ancho del contenido y no es necesario en la página.
    tempDiv.remove();
  }

  /* Inicio del uso de dataTable */
  // Seleccionamos el elemento con el id "datatable" y lo convertimos en un DataTable.
  var table = $("#datatable").DataTable({
    fixedHeader: true,    // Encabezado fijo al hacer scroll.
    stateSave: true,      // Guarda el estado actual de la tabla para recordar las configuraciones personalizadas del usuario.
    stateDuration: 1200,  // Tiempo en milisegundos que se guarda el estado de la tabla en el almacenamiento local.
    responsive: true,     // Permite que la tabla se adapte y sea responsive en diferentes dispositivos.
    dom: var_datatable,   // Define la disposición personalizada de los elementos del DataTable (pueden incluir botones, filtros, etc.).
    language: espaniol,   // Configura el idioma de la tabla, en este caso, español.
    lengthChange: true,   // Permite al usuario cambiar la cantidad de registros mostrados por página.
    select: true,         // Permite la selección de filas en la tabla.
    lengthMenu: [
      // Define las opciones de cantidad de registros por página en el menú desplegable.
      [5, 10, 15, 20, 25, 50, -1],      // Opciones de cantidad de registros.
      [5, 10, 15, 20, 25, 50, 'Todos'], // Etiquetas que se muestran en el menú desplegable.
    ],
    buttons: button_datatable,  // Define los botones personalizados que se agregarán a la tabla.
    pagingType: "full_numbers", // Tipo de paginación, muestra todos los controles disponibles (primero, último, siguiente, anterior, etc.).
    autoFill: {
      enable: true, // Permite el rellenado automático de celdas en la tabla.
    },
    initComplete: function () {
      // Función de inicialización que se ejecuta al completar la creación del DataTable.
      var api = this.api(); // Obtenemos el objeto API del DataTable para interactuar con él.
      var numLastColumnsToDisable = 4; // Número de últimas columnas a deshabilitar.
      disableLastColumns(api, numLastColumnsToDisable); // Llamamos a la función disableLastColumns para deshabilitar las últimas columnas.
    },
  });

  // Evento que se ejecuta cuando se dibuja el DataTable (al cargar o paginar los datos).
  table.on("draw.dt", function () {
    // Seleccionamos todas las celdas visibles en la tabla y recorremos cada celda.
    table.cells(":visible").every(function () {
      var content = this.data();  // Obtenemos el contenido de la celda actual.
      var cellWidth = $(this.node()).width(); // Obtenemos el ancho de la columna donde se encuentra la celda.
      adjustCellContent(this.node(), content, cellWidth); // Llamamos a la función adjustCellContent para ajustar el contenido de la celda.
    });
  });

});