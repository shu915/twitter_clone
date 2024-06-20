# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  tweet_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
