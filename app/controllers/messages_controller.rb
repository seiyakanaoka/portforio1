class MessagesController < ApplicationController

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :room_id, :content).merge(user_id: current_user.id))
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
