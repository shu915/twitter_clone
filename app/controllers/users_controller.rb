# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]
  before_action :authorize_user, only: %i[edit update]

  def show
    @tweets = case params[:tab]
              when 'like'
                @user.liked_tweets.includes(:image_attachment,
                                            user: { avatar_attachment: :blob }).order(created_at: :desc)
                     .page(params[:page]).per(10)
              when 'retweet'
                @user.retweeted_tweets.includes(:image_attachment,
                                                user: { avatar_attachment: :blob }).order(created_at: :desc)
                     .page(params[:page]).per(10)
              when 'comment'
                @user.comments.order(created_at: :desc).page(params[:page]).per(10)
              else
                @user.tweets.includes(image_attachment: :blob)
                     .order(created_at: :desc).page(params[:page]).per(10)
              end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'プロフィールを変更しました。'
      redirect_to user_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def authorize_user
    redirect_to root_path, alert: '権限がありません' unless current_user == @user
  end

  def user_params
    params.require(:user).permit(:account_name, :display_name, :tel, :location, :url, :self_intro, :avatar,
                                 :header_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
