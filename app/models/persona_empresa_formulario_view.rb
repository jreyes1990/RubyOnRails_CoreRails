# == Schema Information
#
# Table name: persona_empresa_formularios_views
#
#  id                :bigint           primary key
#  codigo_area       :integer
#  codigo_empresa    :integer
#  codigo_hex_area   :string
#  codigo_hex_menu   :string
#  codigo_hex_opcion :string
#  codigo_hex_rol    :string
#  descripcion       :string
#  email_usuario     :string
#  estado            :string(10)
#  nombre_area       :string(200)
#  nombre_atributo   :string(200)
#  nombre_componente :string(200)
#  nombre_empresa    :string(200)
#  nombre_menu       :string(200)
#  nombre_opcion     :string(200)
#  nombre_rol        :string(200)
#  nombre_usuario    :text
#  area_id           :bigint
#  atributo_id       :bigint
#  componente_id     :bigint
#  empresa_id        :bigint
#  menu_id           :bigint
#  opcion_ca_id      :bigint
#  opcion_id         :bigint
#  persona_id        :bigint
#  personas_area_id  :bigint
#  rol_id            :integer
#  user_id           :bigint
#
class PersonaEmpresaFormularioView < ApplicationRecord
  self.table_name = "persona_empresa_formularios_views"
  self.primary_key = :id

  def readonly?
    true
  end
end
