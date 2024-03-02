# == Schema Information
#
# Table name: opciones
#
#  id                  :bigint           not null, primary key
#  aplica_carga_masiva :string(10)
#  codigo_hex          :string
#  controlador         :string(300)
#  descripcion         :string
#  estado              :string(10)
#  icono               :string(50)
#  nombre              :string(200)
#  path                :string
#  posicion            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  menu_id             :bigint           not null
#  user_created_id     :integer
#  user_updated_id     :integer
#
# Indexes
#
#  index_opciones_on_menu_id  (menu_id)
#
# Foreign Keys
#
#  fk_rails_...  (menu_id => menus.id)
#
require 'rails_helper'

RSpec.describe Opcion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
