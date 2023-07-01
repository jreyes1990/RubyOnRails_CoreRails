class PersonasAreaDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  #Definición de los Helpers de la vista
  def_delegator :@view, :link_to
  #def_delegator :@view, :tiene_permiso
  def_delegator :@view, :edit_personas_area_path
  def_delegator :@view, :personas_area_path
  def_delegator :@view, :inactivar_personas_area_path
  def_delegator :@view, :activar_personas_area_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: "PersonasAreaView.id", cond: :eq },
      nombre_empresa: { source: "PersonasAreaView.nombre_empresa", cond: :like },
      nombre_area: { source: "PersonasAreaView.nombre_area", cond: :like },
      nombre_usuario: { source: "PersonasAreaView.nombre_usuario", cond: :like },
      email_usuario: { source: "PersonasAreaView.email_usuario", cond: :like },
      nombre_rol: { source: "PersonasAreaView.nombre_rol", cond: :like },
      estado: { source: "PersonasAreaView.estado", cond: :like },
      opciones: { source: "", searchable: false, orderable: false},
      inactivar: { source: "", searchable: false, orderable: false}
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        nombre_empresa: estilo_codigo_hex_empresa_area(record),
        nombre_area: record.nombre_area,
        nombre_usuario: record.nombre_usuario,
        email_usuario: record.email_usuario,
        nombre_rol: estilo_codigo_hex_rol(record),
        estado: format_estado(record),
        opciones: show_btn_opcion(record),
        inactivar: show_btn_inactivar(record)
      }
    end
  end

  def get_raw_records
    PersonasAreaView.order(nombre_empresa: :DESC, nombre_area: :DESC, nombre_rol: :ASC, id: :DESC)
  end

  def show_btn_opcion(record)
    btnOpcion = nil
    #if tiene_permiso("BOTON EDITAR REGISTRO", "VER") || tiene_permiso("BOTON ELIMINAR REGISTRO", "VER")
      if record.estado == 'A'
        #if tiene_permiso("BOTON EDITAR REGISTRO", "VER")
          btnOpcion =  link_to("<i class='fas fa-edit'></i>".html_safe, edit_personas_area_path(record), class: "btn btn-outline-info btn-sm rounded-circle") 
        #else
        #  btnOpcion = ""
        #end
      else
        #if tiene_permiso("BOTON ELIMINAR REGISTRO", "VER")
          btnOpcion =  link_to("<i class='fas fa-trash-alt'></i>".html_safe, personas_area_path(record.id), class: "btn btn-outline-danger btn-sm rounded-circle", method: :delete, data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                  sweetalert_confirm_alert_value: "Eliminar",
                                                                                                                                                                                  sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                  sweetalert_confirm_title_value: 'Esta seguro de eliminar <strong style="color: #1d71b9; font-weight: bold;"><p>'+"#{record.nombre_area}-#{record.nombre_usuario}?"+'</p></strong>',
                                                                                                                                                                                  sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Eliminar</strong>',
                                                                                                                                                                                  sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                  sweetalert_cancel_title_value: 'Se ha cancelado la aliminación de <strong>'+"#{record.nombre_area}-#{record.nombre_usuario}"+'</strong>' },
                                                                                                            'data-custom-class': "popover-danger", title: "ELIMINAR", "data-content": "#{record.id} | #{record.nombre_usuario}-#{record.nombre_area}") 
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
      btnInactivar = link_to("<i class='fas fa-toggle-on' style='transform: rotate(360deg);'></i>".html_safe, inactivar_personas_area_path(:id => record.id), class: "btn btn-outline-danger btn-sm rounded-circle", data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                                                    sweetalert_confirm_alert_value: "Inactivar",
                                                                                                                                                                                                                    sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                                                    sweetalert_confirm_title_value: 'Esta seguro de inactivar <strong style="color: #1d71b9; font-weight: bold;"><p>'+"#{record.nombre_area}-#{record.nombre_usuario}?"+'</p></strong>',
                                                                                                                                                                                                                    sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Inactivar</strong>',
                                                                                                                                                                                                                    sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                                                    sweetalert_cancel_title_value: 'Se ha cancelado la inactivación de <strong>'+"#{record.nombre_area}-#{record.nombre_usuario}"+'</strong>' },
                                                                                                                                                              'data-custom-class': "popover-danger", title: "INACTIVAR", "data-content": "#{record.id} | #{record.nombre_usuario}-#{record.nombre_area}".html_safe) 
    else
      btnInactivar = link_to("<i class='fas fa-toggle-on' style='transform: rotate(180deg);'></i>".html_safe, activar_personas_area_path(:id => record.id), class: "btn btn-outline-success btn-sm rounded-circle", data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                                                  sweetalert_confirm_alert_value: "Activar",
                                                                                                                                                                                                                  sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                                                  sweetalert_confirm_title_value: 'Esta seguro de activar <strong style="color: #1d71b9; font-weight: bold;"><p>'+"#{record.nombre_area}-#{record.nombre_usuario}?"+'</p></strong>',
                                                                                                                                                                                                                  sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Activar</strong>',
                                                                                                                                                                                                                  sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                                                  sweetalert_cancel_title_value: 'Se ha cancelado la activación de <strong>'+"#{record.nombre_area}-#{record.nombre_usuario}"+'</strong>' },
                                                                                                                                                            'data-custom-class': "popover-success", title: "ACTIVAR", "data-content": "#{record.id} | #{record.nombre_usuario}-#{record.nombre_area}") 
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

  def estilo_codigo_hex_empresa_area(record)
    @color_empresa = Empresa.where(id: record.empresa_id).first

    if !@color_empresa.blank?
      color_hex = @color_empresa.codigo_hex
    else
      color_hex = "#F000"
    end

    return "<div class='text-center'><strong style='color: #{color_hex};'>#{record.nombre_empresa.upcase}</strong> - <strong style='color: #{record.codigo_hex_area};'>#{record.nombre_area.upcase}</strong></div>".html_safe
  end

  def estilo_codigo_hex_rol(record)
    @color_rol = Rol.where(id: record.rol_id).first

    if !@color_rol.blank?
      return "<div style='color: #{@color_rol.codigo_hex};'>#{record.nombre_rol.upcase}</div>".html_safe
    end
  end
end
