# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'ツイートに対して返信しました'
      redirect_to tweet_path(@tweet)
    else
      @comments = @tweet.comments.includes(image_attachment: :blob,
                                           user: { avatar_attachment: :blob })
                        .page(params[:page]).per(10).order(created_at: :desc)
      render 'tweets/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :image)
  end
end
