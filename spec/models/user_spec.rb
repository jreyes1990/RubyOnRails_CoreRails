# == Schema Information
#
# Table name: users
#
#  id                        :bigint           not null, primary key
#  consumed_timestep         :integer
#  current_sign_in_at        :datetime
#  current_sign_in_ip        :string
#  email                     :string           default(""), not null
#  encrypted_otp_secret      :string
#  encrypted_otp_secret_iv   :string
#  encrypted_otp_secret_salt :string
#  encrypted_password        :string           default(""), not null
#  estado                    :string
#  last_sign_in_at           :datetime
#  last_sign_in_ip           :string
#  otp_required_for_login    :boolean
#  password_changed          :boolean          default(FALSE)
#  password_changed_at       :datetime
#  remember_created_at       :datetime
#  reset_password_sent_at    :datetime
#  reset_password_token      :string
#  sign_in_count             :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  user_created_id           :integer
#  user_updated_id           :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
