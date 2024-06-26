# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_entry, only: :show

  def index
    my_entries = Entry.where(user_id: current_user.id)
    my_room_ids = my_entries.pluck(:room_id)
    @rooms = Room.where(id: my_room_ids).includes(entries: [user: [avatar_attachment: :blob]]).order(created_at: :desc)
  end

  def create
    @room = Room.new
    @entry1 = Entry.new(room: @room, user_id: current_user.id)
    @entry2 = Entry.new(room: @room, user_id: params[:user_id])

    if @room.save && @entry1.save && @entry2.save
      redirect_to room_path(@room)
    else
      redirect_back(fallback_location: root_path, alert: 'DMルームの作成に失敗しました。')
    end
  end

  def show
    my_entries = Entry.where(user_id: current_user.id)
    my_room_ids = my_entries.pluck(:room_id)
    @rooms = Room.where(id: my_room_ids).includes(entries: [user: [avatar_attachment: :blob]]).order(created_at: :desc)

    @room = Room.find(params[:id])
    @message = Message.new
    @messages = @room.messages.includes(:user)
    room_user = @room.entried_users
    @target_user = room_user.find { |user| user != current_user }
  end

  private

  def check_entry
    room = Room.find(params[:id])
    return if current_user.entried_rooms.exists?(room.id)

    flash[:notice] = '閲覧権がありません'
    redirect_to rooms_path
  end
end
