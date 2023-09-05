# == Schema Information
#
# Table name: credenciales_usuarios
#
#  id                    :bigint           not null, primary key
#  actualizo_password    :string
#  correo_electronico    :string
#  enviar_correo         :string
#  enviar_telegram       :string
#  estado                :string(10)
#  estado_envio_correo   :string
#  estado_envio_telegram :string
#  nombre_area           :string
#  nombre_empresa        :string
#  nombre_usuario        :string
#  password_temporal     :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  area_id               :integer
#  empresa_id            :integer
#  persona_id            :integer
#  user_created_id       :integer
#  user_id               :integer
#  user_updated_id       :integer
#
require 'rails_helper'

RSpec.describe CredencialesUsuario, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
