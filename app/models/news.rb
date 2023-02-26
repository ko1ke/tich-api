class News < ApplicationRecord
  include NewsElasticSerchable

  paginates_per 9

  has_many :favorites, dependent: :destroy
  has_many :favored_users, through: :favorites, source: :user
  has_many :users

  scope :sort_by_newest, -> { order(original_created_at: :desc) }

  def favored_by_user?(user_id)
    favored_user_ids.include?(user_id)
  end

  def self.search(keyword, user_id)
    news = News.joins(:favorites).where(favorites: { user_id: user_id })
    if keyword.present?
      news = news.where(['LOWER(headline) LIKE ?', 'LOWER(body) LIKE ?'].join(' OR '),
                        "%#{keyword.downcase}%",
                        "%#{keyword.downcase}%")
    end
    news
  end
end
