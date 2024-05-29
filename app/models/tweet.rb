# frozen_string_literal: true

# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tweet < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_user, through: :likes, source: :user

  has_many :retweets, dependent: :destroy
  has_many :retweeted_user, through: :retweets, source: :user

  has_many :comments, dependent: :destroy
end
