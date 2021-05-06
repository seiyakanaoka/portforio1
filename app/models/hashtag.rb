class Hashtag < ApplicationRecord
  has_many :hashtag_logs, dependent: :destroy
  has_many :logs, through: :hashtag_logs
end
