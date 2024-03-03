# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :autenticate_2fa!, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def autenticate_2fa!
    user = self.resource = find_user
    return unless user

    if user_params[:otp_attempt].present?
      auth_with_2fa(user)
    elsif user.valid_password?(user_params[:password]) && user.otp_required_for_login
      session[:user_id] = user.id
      @qr_code_svg = generate_qr_code(user)
      UsuarioCodeMailer.send_code(user).deliver_now

      return render "home/two_fa"
    end
  end

  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def auth_with_2fa(user)
    # Asume que el usuario ya ha ingresado la contraseña correctamente y está en el proceso de verificar el OTP.
    return unless user.validate_and_consume_otp!(user_params[:otp_attempt], drift: 30)
    user.save!
    # El código OTP es correcto y dentro del intervalo de tiempo permitido.
    sign_in_and_redirect user, event: :authentication
    # sign_in(user)
  end

  def find_user
    if session[:user_id]
      User.find(session[:user_id])
    elsif user_params[:email]
      return User.find_by(email: user_params[:email])
    end
  end

  # En el controlador o helper donde manejas la configuración de 2FA
  def generate_qr_code(user)
    otp_uri = user.otp_provisioning_uri(user.email, issuer: 'Sistema de Core Rails')
    qrcode = RQRCode::QRCode.new(otp_uri).as_svg(module_size: 3).html_safe
    qrcode
  end

  def user_params
    params.fetch(:user, {}).permit(:password, :otp_attempt, :email, :remember_me)
  end
end
