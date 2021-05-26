class Entry < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def hoge; end
end
