class CodigoColorDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable
  include Utilidades

  #Definición de los Helpers de la vista
  def_delegator :@view, :link_to
  #def_delegator :@view, :tiene_permiso
  def_delegator :@view, :edit_codigo_color_path
  def_delegator :@view, :codigo_color_path
  def_delegator :@view, :inactivar_color_path
  def_delegator :@view, :activar_color_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: "CodigoColor.id", cond: :eq },
      disenio: { source: "CodigoColor.disenio", cond: :like },
      nombre_color: { source: "CodigoColor.nombre_color", cond: :like },
      colores: { source: "CodigoColor.colores", cond: :like },
      codigo_hex: { source: "CodigoColor.codigo_hex", cond: :like },
      codigo_rgb: { source: "CodigoColor.codigo_rgb", cond: :like },
      codigo_hls: { source: "CodigoColor.codigo_hls", cond: :like },
      estado: { source: "CodigoColor.estado", cond: :like },
      opciones: { source: "", searchable: false, orderable: false},
      inactivar: { source: "", searchable: false, orderable: false}
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        disenio: columna_centrada(record.disenio.upcase),
        nombre_color: columna_centrada(record.nombre_color),
        colores: format_estilo_codigo(record.colores),
        codigo_hex: record.codigo_hex,
        codigo_rgb: record.codigo_rgb,
        codigo_hls: record.codigo_hls,
        estado: format_estado(record.estado),
        opciones: show_btn_opcion(record),
        inactivar: show_btn_inactivar(record)
      }
    end
  end

  def get_raw_records
    CodigoColor.order(disenio: :ASC, id: :DESC)
  end

  def show_btn_opcion(record)
    btnOpcion = nil
    #if tiene_permiso("BOTON EDITAR REGISTRO", "VER") || tiene_permiso("BOTON ELIMINAR REGISTRO", "VER")
      if record.estado == 'A'
        #if tiene_permiso("BOTON EDITAR REGISTRO", "VER")
          btnOpcion =  link_to("<i class='fas fa-edit'></i>".html_safe, edit_codigo_color_path(record), class: "btn btn-outline-info btn-sm rounded-circle") 
        #else
        #  btnOpcion = ""
        #end
      else
        #if tiene_permiso("BOTON ELIMINAR REGISTRO", "VER")
          btnOpcion =  link_to("<i class='fas fa-trash-alt'></i>".html_safe, codigo_color_path(record.id), class: "btn btn-outline-danger btn-sm rounded-circle", method: :delete, data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                          sweetalert_confirm_alert_value: "Eliminar",
                                                                                                                                                                                          sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                          sweetalert_confirm_title_value: "Esta seguro de eliminar el color <strong><span class='badge badge-pill badge-white' style='background: #{record.codigo_hex}; color: #{record.codigo_hex};'>#{record.codigo_hex}</span></strong>".html_safe,
                                                                                                                                                                                          sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Eliminar</strong>',
                                                                                                                                                                                          sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                          sweetalert_cancel_title_value: "Se ha cancelado la eliminación de #{record.codigo_hex}"},
                                                                                                            'data-custom-class': "popover-danger", title: "ELIMINAR", "data-content": "#{record.id} | #{record.codigo_hex}") 
        #else
        #  btnOpcion = ""
        #end
      end
    #else
    #  btnOpcion = ""
    #end
    return btnOpcion
  end

  def show_btn_inactivar(record)
    btnInactivar = nil
    #if tiene_permiso("BOTON INACTIVAR REGISTRO", "VER")
    if record.estado == 'A'
      btnInactivar = link_to("<i class='fas fa-toggle-on' style='transform: rotate(360deg);'></i>".html_safe, inactivar_color_path(:id => record.id), class: "btn btn-outline-danger btn-sm rounded-circle", data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                                                      sweetalert_confirm_alert_value: "Inactivar",
                                                                                                                                                                                                                      sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                                                      sweetalert_confirm_title_value: "Esta seguro de inactivar el color <strong><span class='badge badge-pill badge-white' style='background: #{record.codigo_hex}; color: #{record.codigo_hex};'>#{record.codigo_hex}</span></strong>".html_safe,
                                                                                                                                                                                                                      sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Inactivar</strong>',
                                                                                                                                                                                                                      sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                                                      sweetalert_cancel_title_value: "Se ha cancelado la inactivación de #{record.colores}" },
                                                                                                                                                      'data-custom-class': "popover-danger", title: "INACTIVAR", "data-content": "#{record.id} | #{record.codigo_hex}") 
    else
      btnInactivar = link_to("<i class='fas fa-toggle-on' style='transform: rotate(180deg);'></i>".html_safe, activar_color_path(:id => record.id), class: "btn btn-outline-success btn-sm rounded-circle", data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                                                      sweetalert_confirm_alert_value: "Activar",
                                                                                                                                                                                                                      sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                                                      sweetalert_confirm_title_value: "Esta seguro de activar el color <strong><span class='badge badge-pill badge-white' style='background: #{record.codigo_hex}; color: #{record.codigo_hex};'>#{record.codigo_hex}</span></strong>".html_safe,
                                                                                                                                                                                                                      sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Activar</strong>',
                                                                                                                                                                                                                      sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                                                      sweetalert_cancel_title_value: "Se ha cancelado la activación de #{record.colores}" },
                                                                                                                                                    'data-custom-class': "popover-success", title: "ACTIVAR", "data-content": "#{record.id} | #{record.codigo_hex}") 
    end
    #else
    #  btnInactivar = ""
    #end
    return btnInactivar
  end
end
