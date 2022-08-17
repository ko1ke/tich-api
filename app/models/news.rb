class News < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favored_users, through: :favorites, source: :user
  has_many :users

  scope :sort_by_newest, -> { order(original_created_at: :desc) }

  def favored_by_user?(user_id)
    favored_user_ids.include?(user_id)
  end
end
