class Log < ApplicationRecord
  attachment :log_image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :log_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end

  enum weather: {
    ☀️: 0,
    🌥: 1,
    ☔: 2,
  }
end
