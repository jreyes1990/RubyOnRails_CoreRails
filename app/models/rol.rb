# == Schema Information
#
# Table name: roles
#
#  id              :bigint           not null, primary key
#  codigo_hex      :string
#  descripcion     :string
#  estado          :string(10)
#  nombre          :string(200)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
class Rol < ApplicationRecord
  validates_presence_of :nombre, :codigo_hex, :estado, message: ": este campo es obligatorio"
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:codigo_hex, :estado], message: "El Rol que intenta registrar ya existe" }
end
