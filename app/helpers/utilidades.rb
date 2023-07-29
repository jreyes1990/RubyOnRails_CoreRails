module Utilidades
  include ActionView::Helpers::NumberHelper # Importa el helper number_with_delimiter para poder usarlo en tu clase
  require 'mini_magick'
  require 'securerandom'
  require 'net/http'
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
    return "<div class='text-center'><strong><span class='badge badge-pill badge-white' style='background: #{parametro}; color: #{parametro};'>#{parametro}</span></strong></div>".html_safe
  end

  def icono_awesome(parametro)
    return "<div class='text-center'><i class='#{parametro}' aria-hidden='true'></i></div>".html_safe
  end

  def concatena_datos(valor1, valor2)
    return "#{valor1} - #{valor2}"
  end

  def format_digitos(correlativo, valor_digito)
    if !correlativo.nil?
      respuesta = correlativo.to_s.rjust(valor_digito,"0")
    end

    return respuesta
  end

  def custom_query(sql)
    results = ActiveRecord::Base.connection.exec_query(sql)
  
    if results.present?
      return results
    else
      return nil
    end
  end

  def fecha_actual
    t = Time.now
    fecha = t.strftime("%d/%m/%Y")
    return fecha
  end 

  def fecha_actual_ot
    t = Time.now
    fecha = t.strftime("%Y-%m-%d")
    return fecha
  end

  def fecha_hora_actual
    t = Time.now
    fecha = t.strftime("%d/%m/%Y %H:%M:%S")
    return fecha
  end 

  def hora_actual
    t = Time.now
    hora = t.strftime("%H:%M")
    return hora
  end 
  
  def ano_actual
    t = Time.now
    fecha = t.strftime("%Y")
    return fecha
  end 

  # Metodo para contar los registros por modulo, dependiente del estado
  def conteo(modelo, estado, decimales)
    if estado == "0"
      @cantidad = modelo.all.distinct.count
    elsif estado == "A"  
      @cantidad = modelo.where(estado: 'A').distinct.count
    else
      @cantidad = modelo.where(estado: 'I').distinct.count
    end
    # Dar formato de miles al resultado
    @cantidad_formateada = number_with_precision(@cantidad, precision: decimales, delimiter: ',')
  end

  # Metodo para dar tamaño a la imagen
  def resize_image(image, width, height)
    image = MiniMagick::Image.new(image.tempfile.path)
    image.resize "#{width}x#{height}"
    image
  end

  # Metodo para convertir imagen a Base64
  def convert_to_clob(image)
    base64_image = Base64.strict_encode64(image.to_blob)
    "data:image/png;base64,#{base64_image}"
  end

  # Metodo generar una contraseña temporal
  def generate_secure_password(length = 12)
    chars = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['!', '@', '#', '$', '%', '^', '&', '*', '/', '-', '_', '+', '<', '>']
    password = (1..length).map { chars.sample }.join
  end

  # Metodo para validar si hay conexion a internet
  def internet_connection_available?
    url = URI.parse('https://www.google.com')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    http.open_timeout = 5  # Establece un tiempo de espera para la conexión (en segundos)
    response = http.start { |http| http.head('/') } rescue nil

    return !response.nil? && response.is_a?(Net::HTTPOK)
  end
end