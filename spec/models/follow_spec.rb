# frozen_string_literal: true

# == Schema Information
#
# Table name: follows
#
#  id           :bigint           not null, primary key
#  following_id :bigint           not null
#  followed_id  :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Follow, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
