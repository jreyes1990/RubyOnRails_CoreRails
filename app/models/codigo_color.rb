# == Schema Information
#
# Table name: codigo_colores
#
#  id              :bigint           not null, primary key
#  codigo_hex      :string(25)
#  codigo_hls      :string(50)
#  codigo_rgb      :string(50)
#  colores         :string(25)
#  disenio         :string(50)
#  estado          :string(10)
#  nombre_color    :string(100)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
class CodigoColor < ApplicationRecord
    validates_presence_of :colores, :nombre_color, :colores, :codigo_hex, :codigo_rgb, :codigo_hls, message: ": este campo es obligatorio"
    validates :colores, uniqueness: {case_sensitive: false, scope: [:colores, :codigo_hex, :codigo_rgb, :codigo_hls, :estado], message: "El Color que intenta registrar ya existe" }
end
