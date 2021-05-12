class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :log

  validates :user_id, uniqueness: { scope: :log_id }
end
