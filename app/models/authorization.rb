# frozen_string_literal: true

# == Schema Information
#
# Table name: authorizations
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Authorization < ApplicationRecord
  belongs_to :user

  validates :uid, uniqueness: { scope: :provider }
end
