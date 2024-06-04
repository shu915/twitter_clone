# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  tweet_id   :bigint           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  has_one_attached :image

  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %i[png jpg jpeg webp], message: 'はpng, jpeg, jpg, webpのいずれかにしてください' },
                    size: { less_than: 5.megabytes }
end
