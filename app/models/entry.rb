# frozen_string_literal: true

# == Schema Information
#
# Table name: entries
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  room_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room
end
