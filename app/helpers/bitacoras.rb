module Bitacoras
  public

  def genera_credenciales(bitacora, empresa_id, nombre_empresa, area_id, nombre_area, persona_id, 
                          nombre_usuario, user_id, email, pass_temp, enviar_correo, enviar_telegram, 
                          estado_envio_correo, estado_envio_telegram, user_created_id, user_updated_id, 
                          estado)
    if bitacora == "CREACIÓN USUARIO"
      bita = CredencialesUsuario.new
      bita.empresa_id = empresa_id
      bita.nombre_empresa = nombre_empresa
      bita.area_id = area_id
      bita.nombre_area = nombre_area
      bita.persona_id = persona_id
      bita.nombre_usuario = nombre_usuario
      bita.user_id = user_id
      bita.correo_electronico = email
      bita.password_temporal = pass_temp
      bita.enviar_correo = enviar_correo
      bita.enviar_telegram = enviar_telegram
      bita.estado_envio_correo = estado_envio_correo
      bita.estado_envio_telegram = estado_envio_telegram
      bita.user_created_id = user_created_id
      bita.user_updated_id = user_updated_id
      bita.estado = estado
      bita.save
    end
  end
end