# frozen_string_literal: true

# == Schema Information
#
# Table name: notices
#
#  id          :bigint           not null, primary key
#  sender_id   :bigint           not null
#  receiver_id :bigint           not null
#  notice_type :integer          not null
#  like_id     :bigint
#  retweet_id  :bigint
#  reply_id    :bigint
#  read        :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Notice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
