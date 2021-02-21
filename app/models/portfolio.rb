class Portfolio < ApplicationRecord
  validates :ticker, presence: true, length: { maximum: 20 }
  validates :number, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :uid, presence: true
end
