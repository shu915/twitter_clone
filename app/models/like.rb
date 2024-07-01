# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  tweet_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :notices, dependent: :destroy
  counter_culture :tweet
end
