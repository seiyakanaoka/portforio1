class Log < ApplicationRecord
  attachment :log_image

  validates :log_image, presence: true
  validates :weather, presence: true
  validates :dive_depth, presence: true
  validates :dive_number, presence: true
  validates :dive_point, presence: true
  validates :water_temperature, presence: true
  validates :title, length: { maximum: 20 }
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
    âï¸: 0,
    ð¥: 1,
    â: 2
  }

  is_impressionable counter_cache: true, unique: true

  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # DBã¸ã®ã³ãããç´åã«å®æ½ãã
  after_create do
    log = Log.find_by(id: id)
    # æ­£è¦è¡¨ç¾ã§Logã®hashbodyã®ã#ããã¤ããæå­åãæ¤ç´¢ãã
    hashtags = hashbody.scan(/[#ï¼][\w\p{Han}ã-ã¶ï½¦-ï¾ã¼]+/)
    # hashtagså¤æ°ã®ä¸­ã§ãéè¤ãããã®ã¯é¤å¤ããéåã¨ãã¦è¿ãï¼ããããã­ãã¯å¤æ°ã§ä½¿ããããã«ããï¼
    hashtags.uniq.map do |hashtag|
      # ããã·ã¥ã¿ã°ã¯åé ­ã®'#'ãå¤ããä¸ã§ä¿å­ãfind_or_create_byã¡ã½ããã§ããã¼ã¿ã«ãªãå ´åã¯ä½ã
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      # logã®hashtagsã«ä¸è¨ã®æå ±ãå¥ãã
      log.hashtags << tag
    end
  end

  # æ´æ°æã®ã¡ã½ãã
  before_update do
    log = Log.find_by(id: id)
    log.hashtags.clear
    hashtags = hashbody.scan(/[#ï¼][\w\p{Han}ã-ã¶ï½¦-ï¾ã¼]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      log.hashtags << tag
    end
  end

  def create_notification_favorite!(current_user)
    # ãã§ã«ããã­ããã¦ãããæ¤ç´¢
    temp = Notification.where(['visitor_id = ? and visited_id = ? and log_id = ? and action = ? ', current_user.id,
                               user_id, id, 'favorite'])
    # ããã­ããã¦ããªãå ´åã®ã¿ãéç¥ã¬ã³ã¼ããä½æ
    if temp.blank?
      notification = current_user.active_notifications.new(
        log_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # èªåã®æç¨¿ã«å¯¾ããããã­ã®å ´åã¯ãéç¥æ¸ã¿ã¨ãã
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save # ï¼ã¨ã©ã¼ãçºçããå ´åã¯ture, ãªãå ´åã¯falseãè¿ãï¼
    end
  end

  def create_notification_comment!(current_user, log_comment_id)
    # èªåä»¥å¤ã«ã³ã¡ã³ããã¦ããäººãå¨ã¦åå¾ããå¨å¡ã«éç¥ãéã
    temp_ids = LogComment.select(:user_id).where(log_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, log_comment_id, temp_id['user_id'])
    end
    # ã¾ã èª°ãã³ã¡ã³ããã¦ããªãå ´åã¯ãæç¨¿èã«éç¥ãéã
    save_notification_comment!(current_user, log_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, log_comment_id, visited_id)
    # ã³ã¡ã³ããè¤æ°åãããã¨ãèãããããããä¸ã¤ã®æç¨¿å»è¤æ°åéç¥ãã
    notification = current_user.active_notifications.new(
      log_id: id,
      log_comment_id: log_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # èªåã®æç¨¿ã«å¯¾ããã³ã¡ã³ãã®å ´åã¯ãéç¥æ¸ã¿ã¨ãã
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
