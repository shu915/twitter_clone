# frozen_string_literal: true

class RetweetsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = @tweet.retweets.create(user_id: current_user.id)
    current_user.send_notices.create(receiver: @tweet.user, notice_type: 2, retweet: @retweet)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = @tweet.retweets.find_by(user_id: current_user.id)
    @retweet.destroy
    redirect_back(fallback_location: root_path)
  end
end
