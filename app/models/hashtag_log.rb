class HashtagLog < ApplicationRecord
  belongs_to :log
  belongs_to :hashtag
end
