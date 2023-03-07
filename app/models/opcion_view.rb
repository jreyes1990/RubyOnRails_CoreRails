# == Schema Information
#
# Table name: opciones_views
#
#  id              :bigint           primary key
#  codigo_hex      :string
#  codigo_hex_menu :string
#  controlador     :string(300)
#  descripcion     :string
#  estado          :string(10)
#  icono           :string(50)
#  icono_menu      :string(50)
#  nombre          :string(200)
#  nombre_menu     :string(200)
#  path            :string
#  created_at      :datetime
#  updated_at      :datetime
#  menu_id         :bigint
#  user_created_id :integer
#  user_updated_id :integer
#
class OpcionView < ApplicationRecord
  self.table_name = "opciones_views"
  self.primary_key = :id

  def readonly?
    true
  end
end
