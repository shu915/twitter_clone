# frozen_string_literal: true

# == Schema Information
#
# Table name: follows
#
#  id           :bigint           not null, primary key
#  following_id :bigint           not null
#  followed_id  :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Follow < ApplicationRecord
  belongs_to :following, class_name: 'User', inverse_of: :active_relationships
  belongs_to :followed, class_name: 'User', inverse_of: :passive_relationships
end
