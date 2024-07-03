# frozen_string_literal: true

class NoticesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notices = Notice.where(receiver_id: current_user.id).includes(:reply, like: :tweet,
                                                                           retweet: :tweet).order(created_at: :desc)
  end

  def update
    notice = Notice.find(params[:id])
    notice.update(read: true)

    redirect_back(fallback_location: root_path)
  end
end
