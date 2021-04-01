class News < ApplicationRecord
  scope :sort_by_newest, -> { order(original_created_at: :desc) }
end
