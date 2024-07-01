# frozen_string_literal: true

class NoticeMailer < ApplicationMailer
  def notification_email(notice)
    @notice = notice
    @receiver = notice.receiver
    @sender = notice.sender

    mail(
      to: @receiver.email,
      subject: "新しい通知: #{@notice.notice_type}"
    )
  end
end
