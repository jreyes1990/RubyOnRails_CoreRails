# == Schema Information
#
# Table name: empresas
#
#  id              :bigint           not null, primary key
#  codigo_empresa  :integer
#  descripcion     :string
#  estado          :string(10)
#  nombre          :string(200)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
class Empresa < ApplicationRecord
    validates_presence_of :codigo_empresa, :nombre, :estado, message: ": este campo es obligatorio"
    validates :nombre, uniqueness: {case_sensitive: false, scope: [:codigo_empresa, :estado], message: "La Empresa que intenta registrar ya existe" }
end
