class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  layout :layout_by_resource
  include Permisos  
  include Utilidades
  include Bitacoras

  def current_user_empresa_id
    id_empresa_actual = 0
    parametros = Parametro.where(user_id: current_user.id).first

    if (parametros != nil) then
      id_empresa_actual = parametros.empresa_id
      return id_empresa_actual
    else
      return id_empresa_actual = ''
    end
  end

  def comprobar_permiso
    cargar_permisos_usuario(current_user_empresa_id, current_user.id)
    if !tiene_permiso("OPCION", "ACCESAR")
    flash[:error] = "No tienes autorización para ver esta sección"
    redirect_to home_path
    end
  end

  private
    def layout_by_resource
      if devise_controller?
        "devise"
      else
        "application"
      end
    end
end
