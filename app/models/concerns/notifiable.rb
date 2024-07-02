# frozen_string_literal: true

module Notifiable
  extend ActiveSupport::Concern

  included do
    after_create :create_notification
  end

  private

  def create_notification
    Notice.create(
      sender: notification_sender,
      receiver: notification_receiver,
      notice_type: self.class.name.underscore.to_sym,
      like_id: notification_like_id,
      retweet_id: notification_retweet_id,
      reply_id: notification_reply_id
    )
  end

  def notification_like_id
    nil
  end

  def notification_retweet_id
    nil
  end

  def notification_reply_id
    nil
  end
end
