# == Schema Information
#
# Table name: personas_areas
#
#  id              :bigint           not null, primary key
#  descripcion     :string
#  estado          :string(10)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  area_id         :bigint           not null
#  persona_id      :bigint           not null
#  user_created_id :integer
#  user_updated_id :integer
#
# Indexes
#
#  index_personas_areas_on_area_id     (area_id)
#  index_personas_areas_on_persona_id  (persona_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#  fk_rails_...  (persona_id => personas.id)
#
class PersonasArea < ApplicationRecord
  belongs_to :persona
  belongs_to :area

  validates_presence_of :persona_id, :area_id, :estado, message: ": este campo es obligatorio"
  validates :persona_id, uniqueness: {case_sensitive: false, scope: [:area_id, :estado], message: "La Persona-Área que intenta registrar ya existe" }

  def nombre_area
    "#{self.area.empresa.nombre} - #{self.area.nombre} "
  end 

  def user_id
    self.persona.user_id
  end 

  def nombre_persona
    "#{self.persona.nombre} #{self.persona.apellido}"
  end 
end
