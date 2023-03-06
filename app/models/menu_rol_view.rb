# == Schema Information
#
# Table name: menu_roles_views
#
#  id                 :bigint           primary key
#  codigo_hex_menu    :string
#  codigo_hex_opcion  :string
#  codigo_hex_rol     :string
#  controlador_opcion :string(300)
#  descripcion        :string
#  estado             :string(10)
#  icono_menu         :string(50)
#  icono_opcion       :string(50)
#  menu_codigo        :bigint
#  nombre_menu        :string(200)
#  nombre_opcion      :string(200)
#  nombre_rol         :string(200)
#  path_opcion        :string
#  created_at         :datetime
#  updated_at         :datetime
#  menu_id            :integer
#  opcion_id          :bigint
#  rol_id             :bigint
#  user_created_id    :integer
#  user_updated_id    :integer
#
class MenuRolView < ApplicationRecord
    self.table_name = "menu_roles_views"
    self.primary_key = :id
  
    def readonly?
      true
    end
  end
