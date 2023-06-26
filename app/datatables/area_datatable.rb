class AreaDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  #Definición de los Helpers de la vista
  def_delegator :@view, :link_to
  #def_delegator :@view, :tiene_permiso
  def_delegator :@view, :edit_area_path
  def_delegator :@view, :area_path
  def_delegator :@view, :inactivar_area_path
  def_delegator :@view, :activar_area_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: "AreaView.id", cond: :eq },
      nombre_empresa: { source: "AreaView.nombre_empresa", cond: :like },
      codigo_area: { source: "AreaView.codigo_area", cond: :like },
      nombre_area: { source: "AreaView.nombre", cond: :like },
      codigo_hex: { source: "AreaView.codigo_hex", cond: :like },
      descripcion: { source: "AreaView.descripcion", cond: :like },
      estado: { source: "AreaView.estado", cond: :like },
      opciones: { source: "", searchable: false, orderable: false},
      inactivar: { source: "", searchable: false, orderable: false}
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        nombre_empresa: estilo_codigo_hex_empresa(record),
        codigo_area: record.codigo_area,
        nombre_area: record.nombre,
        codigo_hex: estilo_codigo_hex(record),
        descripcion: record.descripcion,
        estado: format_estado(record),
        opciones: show_btn_opcion(record),
        inactivar: show_btn_inactivar(record)
      }
    end
  end

  def get_raw_records
    AreaView.order(nombre_empresa: :ASC, codigo_area: :ASC)
  end

  def show_btn_opcion(record)
    btnOpcion = nil
    #if tiene_permiso("BOTON EDITAR REGISTRO", "VER") || tiene_permiso("BOTON ELIMINAR REGISTRO", "VER")
      if record.estado == 'A'
        #if tiene_permiso("BOTON EDITAR REGISTRO", "VER")
          btnOpcion =  link_to("<i class='fas fa-edit'></i>".html_safe, edit_area_path(record), class: "btn btn-outline-info btn-sm rounded-circle") 
        #else
        #  btnOpcion = ""
        #end
      else
        #if tiene_permiso("BOTON ELIMINAR REGISTRO", "VER")
          btnOpcion =  link_to("<i class='fas fa-trash-alt'></i>".html_safe, area_path(record.id), class: "btn btn-outline-danger btn-sm rounded-circle", method: :delete, data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                  sweetalert_confirm_alert_value: "Eliminar",
                                                                                                                                                                                  sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                  sweetalert_confirm_title_value: 'Esta seguro de eliminar <strong style="color: #1d71b9; font-weight: bold;"><p>'+"#{record.nombre}?"+'</p></strong>',
                                                                                                                                                                                  sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Eliminar</strong>',
                                                                                                                                                                                  sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                  sweetalert_cancel_title_value: 'Se ha cancelado la aliminación de <strong>'+"#{record.nombre}"+'</strong>' }) 
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
      btnInactivar = link_to("<i class='fas fa-toggle-on' style='transform: rotate(360deg);'></i>".html_safe, inactivar_area_path(:id => record.id), class: "btn btn-outline-danger btn-sm rounded-circle", data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                                                    sweetalert_confirm_alert_value: "Inactivar",
                                                                                                                                                                                                                    sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                                                    sweetalert_confirm_title_value: 'Esta seguro de inactivar <strong style="color: #1d71b9; font-weight: bold;"><p>'+"#{record.nombre}?"+'</p></strong>',
                                                                                                                                                                                                                    sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Inactivar</strong>',
                                                                                                                                                                                                                    sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                                                    sweetalert_cancel_title_value: 'Se ha cancelado la inactivación de <strong>'+"#{record.nombre}"+'</strong>' }) 
    else
      btnInactivar = link_to("<i class='fas fa-toggle-on' style='transform: rotate(180deg);'></i>".html_safe, activar_area_path(:id => record.id), class: "btn btn-outline-success btn-sm rounded-circle", data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                                                  sweetalert_confirm_alert_value: "Activar",
                                                                                                                                                                                                                  sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                                                  sweetalert_confirm_title_value: 'Esta seguro de activar <strong style="color: #1d71b9; font-weight: bold;"><p>'+"#{record.nombre}?"+'</p></strong>',
                                                                                                                                                                                                                  sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Activar</strong>',
                                                                                                                                                                                                                  sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                                                  sweetalert_cancel_title_value: 'Se ha cancelado la activación de <strong>'+"#{record.nombre}"+'</strong>' }) 
    end
    #else
    #  btnInactivar = ""
    #end
    return btnInactivar
  end

  def format_estado(record)
    if record.estado == 'A'
      badge_estado = "badge badge-success"
      nombre_estado = "Activo"
    else
      badge_estado = "badge badge-danger"
      nombre_estado = "Inactivo"
    end

    return "<div class='text-center'><span class='#{badge_estado}'>#{nombre_estado}</span></div>".html_safe
  end

  def estilo_codigo_hex(record)
    return "<strong><span class='badge badge-pill badge-white' style='background: #{record.codigo_hex}; color: #{record.codigo_hex};'>#{record.codigo_hex}</span></strong>".html_safe
  end

  def estilo_codigo_hex_empresa(record)
    return "<div class='text-center'><strong style='color: #{record.codigo_hex}'>#{record.nombre_empresa.upcase}</strong></div>".html_safe
  end
end
