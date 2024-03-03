# Preview all emails at http://localhost:3000/rails/mailers/usuario_code
class UsuarioCodePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/usuario_code/send_code
  def send_code
    UsuarioCodeMailer.send_code
  end

end
