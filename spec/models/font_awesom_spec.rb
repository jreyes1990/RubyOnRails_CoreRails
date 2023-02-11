# == Schema Information
#
# Table name: font_awesomes
#
#  id              :bigint           not null, primary key
#  codigo_css      :string(25)
#  estado          :string(10)
#  icono           :string(50)
#  prefijo_nombre  :string(150)
#  termino         :string
#  tipo_icono      :string(50)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
require 'rails_helper'

RSpec.describe FontAwesom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
