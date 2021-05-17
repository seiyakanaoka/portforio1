class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :directs, dependent: :destroy
end
