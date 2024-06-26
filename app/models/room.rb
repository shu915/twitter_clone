# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :entried_users, through: :entries, source: :user

  has_many :messages, dependent: :destroy
end
