class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  layout :layout_by_resource

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

  private
    def layout_by_resource
      if devise_controller?
        "devise"
      else
        "application"
      end
    end
end
