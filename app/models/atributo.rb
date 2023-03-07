# == Schema Information
#
# Table name: atributos
#
#  id              :bigint           not null, primary key
#  descripcion     :string
#  estado          :string(10)
#  nombre          :string(200)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
class Atributo < ApplicationRecord
  has_many :opcion_cas
  
  validates_presence_of :nombre, :estado, message: ": este campo es obligatorio"
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:estado], message: "El Atributo que intenta registrar ya existe" }
end
