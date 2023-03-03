module Utilidades
  public
  def format_estado(parametro)
    if parametro == 'A'
      badge_estado = "badge badge-success"
      nombre_estado = "Activo"
    else
      badge_estado = "badge badge-danger"
      nombre_estado = "Inactivo"
    end

    return "<div class='text-center'><span class='#{badge_estado}'>#{nombre_estado}</span></div>".html_safe
  end

  def format_estilo_codigo(parametro)
    return "<strong><span class='badge badge-pill badge-white' style='background: #{parametro}; color: #{parametro};'>#{parametro}</span></strong>".html_safe
  end

  def icono_awesome(parametro)
    return "<i class='#{parametro}' aria-hidden='true'></i>".html_safe
  end
end