class UsuarioMailer < ApplicationMailer
  before_action :set_base_url

  default from: 'noreply@example.com'  # Cambia según tu configuración

  def set_base_url
    if Rails.env.development?
      @base_url = 'http://localhost:3000'
      @from_url = 'developer.madretierragt@gmail.com'
    else
      @base_url = 'https://poscoope.sistemasmt.com.gt'
      @from_url = 'sistemas@madretierra.com.gt'
    end
  end

  def registro_exitoso(empresa, area, usuario, correo_electronico, temp_password)
    @empresa_usuario = empresa
    @area_usuario = area
    @usuario = usuario
    @email_usuario = correo_electronico
    @password_temp = temp_password
    @enlace_app = "#{@base_url}/users/sign_in"
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/Ingenio_Madre_Tierra.png")

    mail(to: @email_usuario, from: @from_url, subject: 'Bienvenido a sistema de punto de venta: tus credenciales de acceso.', reply_to: 'jreyes1990.test@example.com') # Personaliza el asunto del correo
  end

end
