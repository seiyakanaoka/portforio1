class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  # デフォルトの並び順を作成日時の降順（新しい通知からデータを取得）としている
  belongs_to :log, optional: true
  belongs_to :log_comment, optional: true
  belongs_to :room, optional: true
  belongs_to :message, optional: true
  # optional: trueをつけるとnilが任意になり、必須項目ではなくなる

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
