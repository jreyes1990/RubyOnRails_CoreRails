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
#  rol_id          :integer
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
require 'rails_helper'

RSpec.describe PersonasArea, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
