# == Schema Information
#
# Table name: codigo_colores
#
#  id              :bigint           not null, primary key
#  codigo_hex      :string(25)
#  codigo_hls      :string(50)
#  codigo_rgb      :string(50)
#  colores         :string(25)
#  disenio         :string(50)
#  estado          :string(10)
#  nombre_color    :string(100)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_created_id :integer
#  user_updated_id :integer
#
require 'rails_helper'

RSpec.describe CodigoColor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
