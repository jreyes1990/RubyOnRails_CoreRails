# == Schema Information
#
# Table name: empresas
#
#  id              :bigint           not null, primary key
#  codigo_empresa  :integer
#  codigo_hex      :string
#  descripcion     :string
#  estado          :string(10)
#  nombre          :string(200)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
class Empresa < ApplicationRecord
  has_many :areas
  
  validates_presence_of :nombre, :estado, message: ": este campo es obligatorio"
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:codigo_empresa, :estado], message: "La Empresa que intenta registrar ya existe" }

  def codigo_nombre_empresa
    "#{self.codigo_empresa}: #{self.nombre}"
  end

  def informacion_empresa
    "CÓDIGO: " + "#{self.codigo_empresa}" + " #{self.nombre.upcase}" 
  end

  def empresa_con_codigo
    "#{self.codigo_empresa} | #{self.nombre.upcase}" 
  end
end
