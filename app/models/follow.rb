# frozen_string_literal: true

# == Schema Information
#
# Table name: follows
#
#  id                :bigint           not null, primary key
#  following_user_id :bigint           not null
#  followed_user_id  :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Follow < ApplicationRecord
  # 従属する
  belongs_to :following_user, class_name: 'User', inverse_of: :active_relationships
  belongs_to :followed_user, class_name: 'User', inverse_of: :passive_relationships
end
