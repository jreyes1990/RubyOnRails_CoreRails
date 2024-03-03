class UsuarioCodeMailer < ApplicationMailer
  before_action :set_base_url
  
  def set_base_url
    if Rails.env.development?
      @base_url = 'http://localhost:3000'
      @from_url = 'developer.madretierragt@gmail.com'
    else
      @base_url = 'https://poscoope.sistemasmt.com.gt'
      @from_url = 'sistemas@madretierra.com.gt'
    end
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.usuario_code_mailer.send_code.subject
  #
  def send_code(user)
    @code = user.current_otp

    mail to: "to@example.org"
  end
end
