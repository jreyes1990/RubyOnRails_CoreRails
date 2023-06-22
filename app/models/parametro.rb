# == Schema Information
#
# Table name: parametros
#
#  id                  :bigint           not null, primary key
#  nombre_area         :string
#  nombre_empresa      :string
#  ruta_predeterminada :string
#  view_default        :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  area_id             :integer
#  empresa_id          :integer
#  user_id             :bigint           not null
#
# Indexes
#
#  index_parametros_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Parametro < ApplicationRecord
  belongs_to :user
end
