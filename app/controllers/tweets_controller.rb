# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @tweet = Tweet.new

    if params[:following]
      # following_user_ids = @user.includes().id
      @tweets = Tweet.where(user_id: @user.following_users.pluck(:id))
                     .includes(:user)
                     .order(created_at: :desc).page(params[:page]).per(10)
    else
      @tweets = Tweet.includes(:user,
                               user: [avatar_attachment: :blob]).order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def show; end
end
