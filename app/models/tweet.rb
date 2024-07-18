# frozen_string_literal: true

# == Schema Information
#
# Table name: tweets
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  content         :text             not null
#  likes_count     :integer          default(0), not null
#  retweets_count  :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  bookmarks_count :integer          default(0), not null
#
class Tweet < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user

  has_one :active_relationship, class_name: 'Reply', foreign_key: 'reply_id', dependent: :destroy,
                                inverse_of: :reply
  has_one :parent, through: :active_relationship, source: :parent
  has_many :passive_relationships, class_name: 'Reply', foreign_key: 'parent_id', dependent: :destroy,
                                   inverse_of: :parent
  has_many :replies, through: :passive_relationships, source: :reply

  has_one_attached :image

  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %i[png jpg jpeg webp], message: 'はpng, jpeg, jpg, webpのいずれかにしてください' },
                    size: { less_than: 5.megabytes }
end
