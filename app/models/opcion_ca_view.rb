# == Schema Information
#
# Table name: opcion_cas_views
#
#  id                :bigint           primary key
#  codigo_hex_menu   :string
#  codigo_hex_opcion :string
#  descripcion       :string
#  estado            :string(10)
#  icono_menu        :string(50)
#  icono_opcion      :string(50)
#  nombre_atributo   :string(200)
#  nombre_componente :string(200)
#  nombre_menu       :string(200)
#  nombre_opcion     :string(200)
#  created_at        :datetime
#  updated_at        :datetime
#  atributo_id       :bigint
#  componente_id     :bigint
#  menu_id           :bigint
#  opcion_id         :bigint
#  user_created_id   :integer
#  user_updated_id   :integer
#
class OpcionCaView < ApplicationRecord
  self.table_name = "opcion_cas_views"
  self.primary_key = :id

  def readonly?
      true
  end
end
