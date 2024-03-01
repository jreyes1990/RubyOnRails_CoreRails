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
  extend FriendlyId
  friendly_id :slug, use: :slugged

  has_many :menu_roles
  
  validates_presence_of :nombre, :estado, message: ": este campo es obligatorio"
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:codigo_hex, :estado], message: "El Rol que intenta registrar ya existe" }

  def slug
    # Dividir la cadena en palabras
    palabras = self.nombre.split(" ")
    # Extraer la primera letra de cada palabra
    primeras_letras = palabras.map { |palabra| palabra[0].upcase }

    # Concatenar las primeras letras en una sola cadena
    primeras_letras_juntas = primeras_letras.join

    "#{id}-#{primeras_letras_juntas}".upcase
  end
end
