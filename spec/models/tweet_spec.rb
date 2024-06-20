# frozen_string_literal: true

# == Schema Information
#
# Table name: tweets
#
#  id             :bigint           not null, primary key
#  user_id        :bigint           not null
#  content        :text             not null
#  parent_id      :bigint
#  likes_count    :integer          default(0), not null
#  retweets_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
