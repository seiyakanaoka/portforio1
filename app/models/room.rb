class Room < ApplicationRecord

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries
  has_many :notifications, dependent: :destroy

  def create_notification_message!(current_user, room_id, visited_id, message_id)
    @othermember = Entry.where(room_id: room_id).where.not(user_id: current_user.id)
    @theid = @othermember.find_by(room_id: room_id)
    notification = current_user.active_notifications.new(
      room_id: room_id,
      message_id: message_id,
      visited_id: visited_id,
      visitor_id: current_user.id,
      action: 'dm'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
