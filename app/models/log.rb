class Log < ApplicationRecord
  attachment :image

  belongs_to :user
end
