class News < ApplicationRecord
  paginates_per 15

  scope :sort_by_newest, -> { order(original_created_at: :desc) }
end
