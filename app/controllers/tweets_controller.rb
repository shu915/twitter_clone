# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet = current_user.tweets.new

    @tweets = if params[:following]

                Tweet.where(user_id: current_user.followings.pluck(:id))
                     .includes(image_attachment: :blob, user: { avatar_attachment: :blob })
                     .order(created_at: :desc).page(params[:page]).per(10)
              else
                Tweet.includes(image_attachment: :blob,
                               user: { avatar_attachment: :blob }).order(created_at: :desc)
                     .page(params[:page]).per(10)
              end
  end

  def show
    @tweet = Tweet.find_by(id: params[:id])
    @comments = @tweet.comments.includes(image_attachment: :blob,
                                         user: { avatar_attachment: :blob })
                      .page(params[:page]).per(10).order(created_at: :desc)
    @comment = @tweet.comments.build
  end

  def create
    @tweets = Tweet.includes(:user,
                             user: [avatar_attachment: :blob]).order(created_at: :desc)
                   .page(params[:page]).per(10)
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = 'ツイートを投稿しました。'
      redirect_to root_path
    else
      render 'tweets/index', status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end
