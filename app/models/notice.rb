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
class Notice < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: :send_notices
  belongs_to :receiver, class_name: 'User', inverse_of: :received_notices

  belongs_to :like, optional: true
  belongs_to :retweet, optional: true
  belongs_to :reply, optional: true, class_name: 'Tweet'

  enum notice_type: { follow: 0, like: 1, retweet: 2, reply: 3 }

  after_create :send_notification_email

  def send_notification_email
    NoticeMailer.notification_email(self).deliver_now
  end
end
