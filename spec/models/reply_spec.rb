# frozen_string_literal: true

# == Schema Information
#
# Table name: replies
#
#  id         :bigint           not null, primary key
#  parent_id  :bigint           not null
#  reply_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Reply, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
