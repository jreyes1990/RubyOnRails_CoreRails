# == Schema Information
#
# Table name: persona_empresa_formularios
#
#  id               :bigint           not null, primary key
#  descripcion      :string
#  estado           :string(10)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  opcion_ca_id     :bigint           not null
#  personas_area_id :bigint           not null
#  user_created_id  :integer
#  user_updated_id  :integer
#
# Indexes
#
#  index_persona_empresa_formularios_on_opcion_ca_id      (opcion_ca_id)
#  index_persona_empresa_formularios_on_personas_area_id  (personas_area_id)
#
# Foreign Keys
#
#  fk_rails_...  (opcion_ca_id => opcion_cas.id)
#  fk_rails_...  (personas_area_id => personas_areas.id)
#
class PersonaEmpresaFormulario < ApplicationRecord
  belongs_to :personas_area
  belongs_to :opcion_ca
end
