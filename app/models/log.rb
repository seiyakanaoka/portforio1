class Log < ApplicationRecord
  attachment :log_image

  belongs_to :user

  enum weather: {
    ☀️: 0,
    🌥: 1,
    ☔: 2,
  }
end
