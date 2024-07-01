# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = @tweet.likes.create(user_id: current_user.id)
    current_user.send_notices.create(receiver: @tweet.user, notice_type: 1, like: @like)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @like = @tweet.likes.find_by(user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
