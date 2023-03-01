# == Schema Information
#
# Table name: areas_views
#
#  id                    :bigint           primary key
#  codigo_area           :integer
#  codigo_empresa        :integer
#  codigo_hex            :string
#  codigo_nombre_empresa :text
#  descripcion           :string
#  estado                :string(10)
#  nombre                :string(200)
#  nombre_empresa        :string(200)
#  created_at            :datetime
#  updated_at            :datetime
#  empresa_id            :bigint
#  user_created_id       :integer
#  user_updated_id       :integer
#
class AreaView < ApplicationRecord
  self.table_name = "areas_views"
  self.primary_key = :id

  def readonly?
    true
  end
end
