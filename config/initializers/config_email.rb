Rails.application.configure do
    # config/environments/development.rb o config/environments/production.rb
    config.action_mailer.perform_caching = false
    config.assets.raise_runtime_errors = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp       # Establece el método de entrega de correo electrónico, en este caso, SMTP
    config.action_mailer.default :charset => "utf-8"
    config.action_mailer.default_options = { from: 'noreply@example.com' }

    # Configuración específica para el servidor SMTP de Gmail
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",                # Reemplaza con la dirección del servidor SMTP que utilizarás
      port: 587,                                # Reemplaza con el puerto adecuado
      domain: "madretierra.com.gt",             # Reemplaza con tu propio dominio
      user_name: "jreyes@madretierra.com.gt",   # Reemplaza con tu propio correo electrónico de Gmail
      password: "Jarl@1990",                    # Reemplaza con tu propia contraseña de Gmail
      authentication: "plain",
      enable_starttls_auto: true,
      openssl_verify_mode: "none"
    }

    # Configura las opciones de URL predeterminadas para generar URLs en los correos electrónicos
    config.action_mailer.default_url_options = { :host => "localhost:3000" }
  end