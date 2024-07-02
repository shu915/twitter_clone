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
class Reply < ApplicationRecord
  belongs_to :reply, class_name: 'Tweet', inverse_of: :active_relationship
  belongs_to :parent, class_name: 'Tweet', inverse_of: :passive_relationships

  include Notifiable

  private

  def notification_sender
    reply.user
  end

  def notification_receiver
    parent.user
  end

  def notification_reply_id
    id
  end
end
