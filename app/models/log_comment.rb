class LogComment < ApplicationRecord
  belongs_to :user
  belongs_to :log
  belongs_to :log_comment, foreign_key: :reply_comment, optional: true
  has_many :replies, class_name: "LogComment", foreign_key: :reply_comment, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # def self.parent_comments
  #   where(reply_comment: nil)
  # end
  # これはnextとまた別の方法の返信機能メソッド
  # 一つのコメントに返信を繰り返させるために使用
end
