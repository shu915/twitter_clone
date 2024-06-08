# frozen_string_literal: true

# == Schema Information
#
# Table name: retweets
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  tweet_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Retweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  counter_culture :tweet
end
