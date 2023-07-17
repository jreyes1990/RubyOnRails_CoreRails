class UsuarioMailer < ApplicationMailer
  default from: 'jreyes@madretierra.com.gt'  # Cambia según tu configuración

  def registro_exitoso(correo_electronico)
    @usuario = correo_electronico
    mail(to: @usuario, subject: 'Registro exitoso, puede acceder a la siguiente rutal, http://localhost:3000') # Personaliza el asunto del correo
  end

end
