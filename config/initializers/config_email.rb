Rails.application.configure do
  if Rails.env.development?
    @base_domain = "gmail.com"
    @base_user_name = "jreyes1990.test@gmail.com"
    @base_password = "csxkofjlwacdtgmw"
    @base_host = "http://localhost:3000"
  else
    @base_domain = "gmail.com"
    @base_user_name = "jreyes1990.test@gmail.com"
    @base_password = "csxkofjlwacdtgmw"
    @base_host = "http://localhost:3000"
  end
    # config/environments/development.rb o config/environments/production.rb
    config.action_mailer.perform_caching = false
    config.assets.raise_runtime_errors = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :letter_opener # Configura la opcion para abrir el correo electronico a otra pestania
    # config.action_mailer.delivery_method = :smtp       # Establece el método de entrega de correo electrónico, en este caso, SMTP
    config.action_mailer.default :charset => "utf-8"
    config.action_mailer.default_options = { from: 'noreply@example.com' }

    # Configuración específica para el servidor SMTP de Gmail
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",        # Reemplaza con la dirección del servidor SMTP que utilizarás
      port: 587,                        # Reemplaza con el puerto adecuado
      domain: @base_domain,             # Reemplaza con tu propio dominio
      user_name: @base_user_name,       # Reemplaza con tu propio correo electrónico de Gmail
      password: @base_password,         # Reemplaza con tu propia contraseña de Gmail
      authentication: "plain",
      enable_starttls_auto: true,
      openssl_verify_mode: "none"
    }

    # Configura las opciones de URL predeterminadas para generar URLs en los correos electrónicos
    config.action_mailer.default_url_options = { host: @base_host }
end