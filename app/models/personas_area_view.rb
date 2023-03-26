# == Schema Information
#
# Table name: personas_areas_views
#
#  id               :bigint           primary key
#  codigo_area      :integer
#  codigo_empresa   :integer
#  codigo_hex_area  :string
#  descripcion      :string
#  email_usuario    :string
#  estado           :string(10)
#  nombre_area      :string(200)
#  nombre_empresa   :string(200)
#  nombre_usuario   :text
#  telefono_usuario :integer
#  created_at       :datetime
#  updated_at       :datetime
#  area_id          :bigint
#  empresa_id       :bigint
#  persona_id       :bigint
#  user_created_id  :integer
#  user_id          :bigint
#  user_updated_id  :integer
#
class PersonasAreaView < ApplicationRecord
    self.table_name = "personas_areas_views"
    self.primary_key = :id
  
    def readonly?
        true
    end
  end
