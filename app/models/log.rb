class Log < ApplicationRecord
  attachment :log_image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :log_comments, dependent: :destroy
  has_many :replies, class_name: "LogComment", foreign_key: :reply_comment, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end

  enum weather: {
    ☀️: 0,
    🌥: 1,
    ☔: 2,
  }

  is_impressionable counter_cache: true, :unique => true

  has_many :hashtag_logs, dependent: :destroy
  has_many :hashtags, through: :hashtag_logs, dependent: :destroy

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

end
