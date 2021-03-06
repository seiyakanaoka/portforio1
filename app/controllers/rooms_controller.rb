class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    Entry.create(room_id: @room.id, user_id: current_user.id)
    Entry.create(rooms_params.merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def index
    @user = current_user
    @currentEntries = current_user.entries.includes(:room)
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.includes(:user).where(room_id: myRoomIds).where('user_id != ?', @user)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entry = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def rooms_params
    params.require(:entry).permit(:user_id, :room_id)
  end
end
