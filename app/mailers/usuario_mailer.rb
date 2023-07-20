class UsuarioMailer < ApplicationMailer
  default from: 'noreply@example.com'  # Cambia según tu configuración

  def registro_exitoso(empresa, area, usuario, correo_electronico, temp_password)
    @empresa_usuario = empresa
    @area_usuario = area
    @usuario = usuario
    @email_usuario = correo_electronico
    @password_temp = temp_password
    @enlace_app = "http://localhost:3000"
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/Ingenio_Madre_Tierra.png")

    #mail(to: @email_usuario, subject: 'Bienvenido a nuestro sistema') # Personaliza el asunto del correo
    mail(bcc: @email_usuario, subject: 'Bienvenido a nuestro sistema') # Personaliza el asunto del correo
  end

end
