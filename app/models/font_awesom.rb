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
class FontAwesom < ApplicationRecord
  has_rich_text :observacion
  has_one_attached :main_image
  has_many_attached :other_images

  validates_presence_of :icono, :tipo_icono, message: ": este campo es obligatorio"
  validates :icono, uniqueness: {case_sensitive: false, scope: :estado, message: "El Icono que intenta registrar ya existe" }

  def attach_other_images(signed_blob_id)
    blob = ActiveStorage::Blob.find_signed(signed_blob_id)
    return other_images.attach(signed_blob_id) unless blob.present?

    other_images.attach(blob.signed_id) unless other_images.attachments.map(&:blob_id).include?(blob.id)
  end
end
