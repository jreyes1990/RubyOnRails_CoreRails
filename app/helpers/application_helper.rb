module ApplicationHelper
  include Utilidades
  include Permisos
  include Bitacoras

  def helper_current_user_empresa_id
    id_empresa_actual = 0
    parametros = Parametro.where(:user_id => current_user.id).first

    if (parametros != nil) then
      id_empresa_actual = parametros.empresa_id        
      return id_empresa_actual
    else
      return id_empresa_actual = ''
    end       
  end
  
  def current_user_name
    persona = Persona.where(user_id: current_user.id).first

    if !persona.nil?
      if (!persona.nombre.nil? || !persona.apellido.nil?)
        return "#{persona.nombre.upcase} #{persona.apellido.upcase}"
      else
        return current_user.email
      end
    else
      return current_user.email
    end
  end

  def current_user_role
    role_persona =  PersonasAreaView.where(user_id: current_user.id).first

    if !role_persona.nil?
      if (!role_persona.nombre_rol.nil?)
        return "#{role_persona.nombre_rol.upcase}"
      end
    end
  end

  def current_user_role_color
    role_persona_color =  PersonasAreaView.where(user_id: current_user.id).first

    if !role_persona_color.nil?
      if (!role_persona_color.nombre_rol.nil?)
        return "#{role_persona_color.codigo_hex_rol}"
      end
    end
  end

  def current_nombre_area_controller
    parametro_area = Parametro.where(user_id: current_user.id).first

    if (parametro_area != nil) then
      nombre_area = parametro_area.nombre_area.upcase
      return nombre_area
    else
      return nombre_area = ''
    end
  end

  def current_nombre_area_empresa_controller
    parametro_area = Parametro.where(user_id: current_user.id).first

    if (parametro_area != nil) then
      nombre_empresa = parametro_area.nombre_empresa.upcase
      return nombre_empresa
    else
      return nombre_empresa = ''
    end
  end

  def is_active_action(controller)
    if params[:controller] == controller
      "collapse-item active"
    else
      "collapse-item"
    end
  end
  
  # METODOS DE ACTIVACION EN SIDEBAR - INICIO
  def is_home_active
    if params[:controller] == "home"
      "nav-item active"
    else
      "nav-item"
    end
  end

  # METODOS DE ACTIVACION EN SIDEBAR - ICONOS
  def is_active_controller_icono_titulo
    @controladores = ["font_awesomes", "codigo_colores"]
    if @controladores.include? params[:controller]
      "nav-item active"
    else
      "nav-item"
    end
  end

  def is_active_controller_icono
    @controladores = ["font_awesomes", "codigo_colores"]
    if @controladores.include? params[:controller]
      "nav-link"
    else
      "nav-link collapsed"
    end
  end

  def is_active_option_controller_icono
    @controladores = ["font_awesomes", "codigo_colores"]
    if @controladores.include? params[:controller]
      "collapse show"
    else
      "collapse"
    end
  end

  # METODOS DE ACTIVACION EN SIDEBAR - CONFIGURACIÓN SISTEMA
  def is_active_controller_sistema_titulo
    @controladores = ["usuarios","empresas","areas","personas_areas","roles","menus","opciones","menu_roles","atributos","componentes","opcion_cas","persona_empresa_formularios"]
    if @controladores.include? params[:controller]
      "nav-item active"
    else
      "nav-item"
    end
  end

  def is_active_controller_sistema
    @controladores = ["usuarios","empresas","areas","personas_areas","roles","menus","opciones","menu_roles","atributos","componentes","opcion_cas","persona_empresa_formularios"]
    if @controladores.include? params[:controller]
      "nav-link"
    else
      "nav-link collapsed"
    end
  end

  def is_active_option_controller_sistema
    @controladores = ["usuarios","empresas","areas","personas_areas","roles","menus","opciones","menu_roles","atributos","componentes","opcion_cas","persona_empresa_formularios"]
    if @controladores.include? params[:controller]
      "collapse show"
    else
      "collapse"
    end
  end
end
