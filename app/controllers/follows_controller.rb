# frozen_string_literal: true

class FollowsController < ApplicationController
  def index
    @users = if params[:followed]
               current_user.followeds.includes(avatar_attachment: :blob)
             else
               current_user.followings.includes(avatar_attachment: :blob)
             end
  end

  def create
    target_user = User.find(params[:user_id])
    current_user.followings << target_user
    redirect_back(fallback_location: root_path)
  end

  def destroy
    target_user = User.find(params[:user_id])
    current_user.followings.delete(target_user)
    redirect_back(fallback_location: root_path)
  end
end
