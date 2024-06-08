# frozen_string_literal: true

# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  content    :text             not null
#  parent_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tweet < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user

  belongs_to :parent, class_name: 'Tweet', optional: true, inverse_of: :replies
  has_many :replies, class_name: 'Tweet', foreign_key: 'parent_id', dependent: :destroy, inverse_of: :parent

  has_one_attached :image

  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %i[png jpg jpeg webp], message: 'はpng, jpeg, jpg, webpのいずれかにしてください' },
                    size: { less_than: 5.megabytes }
end
