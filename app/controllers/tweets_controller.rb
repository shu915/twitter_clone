# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet = current_user.tweets.new

    if params[:following]
      set_following_tweets
    else
      set_all_tweets
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @replies = @tweet.replies.includes(image_attachment: :blob,
                                       user: { avatar_attachment: :blob })
                     .page(params[:page]).per(10).order(created_at: :desc)
    @reply_tweet = current_user.tweets.build
  end

  def create
    @tweets = Tweet.includes(user: {avatar_attachment: :blob}).order(created_at: :desc)
                   .page(params[:page]).per(10)
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = 'ツイートを投稿しました。'
      redirect_to root_path
    else
      render 'tweets/index', status: :unprocessable_entity
    end
  end

  def reply_create
    @tweet = Tweet.find(params[:tweet_id])
    @reply_tweet = current_user.tweets.build(tweet_params)
    @replies = @tweet.replies
    if @reply_tweet.save
      Reply.create(parent_id: @tweet.id, reply_id: @reply_tweet.id)
      redirect_to tweet_path(@tweet), notice: '返信が投稿されました'

    else
      render 'tweets/show', status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end

  def set_following_tweets
    following_ids = current_user.followings.pluck(:id)

    tweets = Tweet.where(user_id: following_ids)
                  .includes(image_attachment: :blob, user: { avatar_attachment: :blob })
                  .map { |tweet| { object: tweet, created_at: tweet.created_at } }

    retweets = Retweet.where(user_id: following_ids)
                      .includes(tweet: [image_attachment: :blob, user: { avatar_attachment: :blob }])
                      .map do |retweet|
      { object: retweet.tweet, created_at: retweet.created_at }
    end

    merged_tweets = (tweets + retweets).uniq { |tweet| tweet[:object].id }

    sorted_tweets = merged_tweets.sort_by { |tweet| tweet[:created_at] }.reverse

    result = sorted_tweets.map { |tweet| tweet[:object] }
    @tweets = Kaminari.paginate_array(result).page(params[:page]).per(10)
  end

  def set_all_tweets
    tweets = Tweet.includes(:image_attachment,
                            :retweets,
                            user: { avatar_attachment: :blob })

    sorted_tweets = tweets.sort_by do |tweet|
      tweet.retweets.max_by(&:created_at)&.created_at || tweet.created_at
    end
    @tweets = Kaminari.paginate_array(sorted_tweets.reverse).page(params[:page]).per(10)
  end
end
