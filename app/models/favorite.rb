class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :news

  validates_uniqueness_of :news_id, scope: :user_id
end
