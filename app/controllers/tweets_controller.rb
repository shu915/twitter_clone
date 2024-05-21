# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user

  def index
    @user = current_user
  end

  def show; end

  private

  def authenticate_user
    redirect_to new_user_session_path unless current_user
  end
end
