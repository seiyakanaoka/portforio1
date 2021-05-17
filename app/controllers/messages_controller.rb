class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :room_id, :content).merge(user_id: current_user.id))
      @room = @message.room

      @othermember = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
      @theid = @othermember.find_by(room_id: @room.id)
      direct = current_user.active_directs.new(
        room_id: @room.id,
        message_id: @message.id,
        visited_id: @theid.user_id,
        visitor_id: current_user.id,
        action: 'dm'
      )
      if direct.visitor_id == direct.visited_id
        direct.checked = true
      end
      direct.save if direct.valid?

    else
      redirect_back(fallback_location: root_path)
    end
  end
end
