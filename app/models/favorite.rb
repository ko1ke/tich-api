class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :news

  validates :news_id, uniqueness: { scope: :user_id }
end
