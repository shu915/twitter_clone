# frozen_string_literal: true

class BookmarksController < ApplicationController
  def index
    @bookmark = current_user.bookmarks.includes(tweet: [:image_attachment, {
                                                  user: { avatar_attachment: :blob }
                                                }]).order(created_at: :desc)
                            .page(params[:page]).per(10)
  end

  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.bookmarked_tweets << tweet
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    bookmark = tweet.bookmarks.find_by(user_id: current_user.id)
    bookmark.destroy
    redirect_back(fallback_location: root_path)
  end
end
