# == Schema Information
#
# Table name: menu_roles
#
#  id              :bigint           not null, primary key
#  descripcion     :string
#  estado          :string(10)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  menu_id         :integer
#  opcion_id       :bigint           not null
#  rol_id          :bigint           not null
#  user_created_id :integer
#  user_updated_id :integer
#
# Indexes
#
#  index_menu_roles_on_opcion_id  (opcion_id)
#  index_menu_roles_on_rol_id     (rol_id)
#
# Foreign Keys
#
#  fk_rails_...  (opcion_id => opciones.id)
#  fk_rails_...  (rol_id => roles.id)
#
require 'rails_helper'

RSpec.describe MenuRol, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
