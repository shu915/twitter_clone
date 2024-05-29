# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

    @tweets = case params[:tab]
              when 'like'
                @user.liked_tweets.includes(:user,
                                            user: [avatar_attachment: :blob]).order(created_at: :desc)
                     .page(params[:page]).per(10)
              when 'retweet'
                @user.retweeted_tweets.includes(:user,
                                                user: [avatar_attachment: :blob]).order(created_at: :desc)
                     .page(params[:page]).per(10)
              when 'comment'
                @user.comments.order(created_at: :desc).page(params[:page]).per(10)
              else
                @user.tweets.order(created_at: :desc).page(params[:page]).per(10)
              end
  end
end
