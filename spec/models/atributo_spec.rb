# == Schema Information
#
# Table name: atributos
#
#  id              :bigint           not null, primary key
#  descripcion     :string
#  estado          :string(10)
#  nombre          :string(200)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
require 'rails_helper'

RSpec.describe Atributo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
