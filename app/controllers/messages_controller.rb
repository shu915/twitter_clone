# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    if @message.save
      redirect_to room_path(@room)
    else
      @rooms = Room.includes(entries: [user: [avatar_attachment: :blob]]).order(created_at: :desc)
      room_user = @room.entried_users
      @target_user = room_user.find { |user| user != current_user }
      @messages = @room.messages.includes(:user)
      render 'rooms/show', status: :unprocessable_entity

    end
  end

  private

  def message_params
    params.require(:message).permit(:message).merge(user_id: current_user.id)
  end
end
