class FontAwesomDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  #Definición de los Helpers de la vista
  def_delegator :@view, :link_to
  #def_delegator :@view, :tiene_permiso
  def_delegator :@view, :edit_font_awesom_path
  def_delegator :@view, :font_awesom_path
  def_delegator :@view, :inactivar_awesome_path
  def_delegator :@view, :activar_awesome_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: "FontAwesom.id", cond: :eq },
      icono: { source: "FontAwesom.icono", cond: :like },
      prefijo_nombre: { source: "FontAwesom.prefijo_nombre", cond: :like },
      codigo_css: { source: "FontAwesom.codigo_css", cond: :like },
      tipo_icono: { source: "FontAwesom.tipo_icono", cond: :like },
      termino: { source: "FontAwesom.termino", cond: :like },
      estado: { source: "FontAwesom.estado", cond: :like },
      opciones: { source: "", searchable: false, orderable: false},
      inactivar: { source: "", searchable: false, orderable: false}
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        icono: icono_awesome(record),
        prefijo_nombre: record.prefijo_nombre,
        codigo_css: codigo_css_awesome(record),
        tipo_icono: record.tipo_icono,
        termino: record.termino,
        estado: format_estado(record),
        opciones: show_btn_opcion(record),
        inactivar: show_btn_inactivar(record)
      }
    end
  end

  def get_raw_records
    FontAwesom.order(id: :DESC)
  end

  def show_btn_opcion(record)
    btnOpcion = nil
    #if tiene_permiso("BOTON EDITAR REGISTRO", "VER") || tiene_permiso("BOTON ELIMINAR REGISTRO", "VER")
      if record.estado == 'A'
        #if tiene_permiso("BOTON EDITAR REGISTRO", "VER")
          btnOpcion =  link_to("<i class='fas fa-edit'></i>".html_safe, edit_font_awesom_path(record), class: "btn btn-outline-info btn-sm rounded-circle") 
        #else
        #  btnOpcion = ""
        #end
      else
        #if tiene_permiso("BOTON ELIMINAR REGISTRO", "VER")
          btnOpcion =  link_to("<i class='fas fa-trash-alt'></i>".html_safe, font_awesom_path(record.id), class: "btn btn-outline-danger btn-sm rounded-circle", method: :delete, data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                        sweetalert_confirm_alert_value: "Eliminar",
                                                                                                                                                                                        sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                        sweetalert_confirm_title_value: 'Esta seguro de eliminar el icono <i class="'+"#{record.icono}"+'"</i>',
                                                                                                                                                                                        sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Eliminar</strong>',
                                                                                                                                                                                        sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                        sweetalert_cancel_title_value: "Se ha cancelado la eliminación de #{record.icono}"}) 
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
      btnInactivar = link_to("<i class='fas fa-toggle-on' style='transform: rotate(360deg);'></i>".html_safe, inactivar_awesome_path(:id => record.id), class: "btn btn-outline-danger btn-sm rounded-circle", data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                                                      sweetalert_confirm_alert_value: "Inactivar",
                                                                                                                                                                                                                      sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                                                      sweetalert_confirm_title_value: 'Esta seguro de inactivar el icono <i class="'+"#{record.icono}"+'"</i>',
                                                                                                                                                                                                                      sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Inactivar</strong>',
                                                                                                                                                                                                                      sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                                                      sweetalert_cancel_title_value: "Se ha cancelado la inactivación de #{record.icono}" }) 
    else
      btnInactivar = link_to("<i class='fas fa-toggle-on' style='transform: rotate(180deg);'></i>".html_safe, activar_awesome_path(:id => record.id), class: "btn btn-outline-success btn-sm rounded-circle", data: {controller: 'sweetalert', action: 'click->sweetalert#btnInactivar',
                                                                                                                                                                                                                      sweetalert_confirm_alert_value: "Activar",
                                                                                                                                                                                                                      sweetalert_cancel_alert_value: "Cancelado",
                                                                                                                                                                                                                      sweetalert_confirm_title_value: 'Esta seguro de activar el icono <i class="'+"#{record.icono}"+'"</i>',
                                                                                                                                                                                                                      sweetalert_confirm_btn_value: '<i class="fas fa-check-circle"></i> <strong>Si, Activar</strong>',
                                                                                                                                                                                                                      sweetalert_cancel_btn_value: '<i class="fas fa-times-circle"></i> <strong>No, Cancelar</strong>',
                                                                                                                                                                                                                      sweetalert_cancel_title_value: "Se ha cancelado la activación de #{record.icono}" }) 
    end
    #else
    #  btnInactivar = ""
    #end
    return btnInactivar
  end

  def icono_awesome(record)
    iconoFontAwesome = "<i class='#{record.icono}' aria-hidden='true'></i>".html_safe

    return iconoFontAwesome
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

  def codigo_css_awesome(record)
    return "<div class='text-center'><span style='content: #{record.codigo_css}'>#{record.codigo_css}</span></div>".html_safe
  end
end
