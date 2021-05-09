class Map < ApplicationRecord
  belongs_to :log
  belongs_to :user
end
