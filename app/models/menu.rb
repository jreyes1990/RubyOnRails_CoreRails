# == Schema Information
#
# Table name: menus
#
#  id              :bigint           not null, primary key
#  codigo_hex      :string
#  descripcion     :string
#  estado          :string(10)
#  icono           :string(50)
#  nombre          :string(200)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
class Menu < ApplicationRecord
  validates_presence_of :nombre, :icono, :codigo_hex, :estado, message: ": este campo es obligatorio"
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:icono, :codigo_hex, :estado], message: "El Menú que intenta registrar ya existe" }
end
