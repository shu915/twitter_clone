# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  room_id    :bigint           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true, length: { maximum: 140 }
end
