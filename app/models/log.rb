class Log < ApplicationRecord
  attachment :log_image

  validates :log_image, presence: true
  validates :weather, presence: true
  validates :dive_depth, presence: true
  validates :dive_number, presence: true
  validates :dive_point, presence: true
  validates :water_temperature, presence: true
  validates :title, length: { maximum: 12 }
  validates :body, length: { maximum: 150 }
  validates :address, presence: true

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :log_comments, dependent: :destroy
  # has_many :replies, class_name: "LogComment", foreign_key: :reply_comment, dependent: :destroy
  has_many :hashtag_logs, dependent: :destroy
  has_many :hashtags, through: :hashtag_logs
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  geocoded_by :address
  after_validation :geocode

    enum weather: {
    ☀️: 0,
    🌥: 1,
    ☔: 2,
  }

  is_impressionable counter_cache: true, :unique => true

  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

   #DBへのコミット直前に実施する
  after_create do
    log = Log.find_by(id: self.id)
    hashtags  = self.hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      log.hashtags << tag
    end
  end

  before_update do
    log = Log.find_by(id: self.id)
    log.hashtags.clear
    hashtags = self.hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      log.hashtags << tag
    end
  end

  def create_notification_favorite!(current_user)
    # すでにいいねされているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and log_id = ? and action = ? ', current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        log_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?  # （エラーが発生した場合はture, ない場合はfalseを返す）
    end
  end

  def create_notification_comment!(current_user, log_comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = LogComment.select(:user_id).where(log_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, log_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, log_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, log_comment_id, visited_id)
    # コメントが複数回することが考えられるため、一つの投稿医複数回通知する
    notification = current_user.active_notifications.new(
      log_id: id,
      log_comment_id: log_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
