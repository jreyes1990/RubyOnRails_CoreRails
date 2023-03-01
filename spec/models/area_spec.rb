# == Schema Information
#
# Table name: areas
#
#  id              :bigint           not null, primary key
#  codigo_area     :integer
#  codigo_hex      :string
#  descripcion     :string
#  estado          :string(10)
#  nombre          :string(200)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  empresa_id      :bigint           not null
#  user_created_id :integer
#  user_updated_id :integer
#
# Indexes
#
#  index_areas_on_empresa_id  (empresa_id)
#
# Foreign Keys
#
#  fk_rails_...  (empresa_id => empresas.id)
#
require 'rails_helper'

RSpec.describe Area, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
