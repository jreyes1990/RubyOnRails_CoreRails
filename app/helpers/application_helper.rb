module ApplicationHelper
  include Utilidades
  include Permisos

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
    @controladores = ["empresas","areas","menus","atributos","componentes"]
    if @controladores.include? params[:controller]
      "nav-item active"
    else
      "nav-item"
    end
  end

  def is_active_controller_sistema
    @controladores = ["empresas","areas","menus","atributos","componentes"]
    if @controladores.include? params[:controller]
      "nav-link"
    else
      "nav-link collapsed"
    end
  end

  def is_active_option_controller_sistema
    @controladores = ["empresas","areas","menus","atributos","componentes"]
    if @controladores.include? params[:controller]
      "collapse show"
    else
      "collapse"
    end
  end
end
