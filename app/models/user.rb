class User < ApplicationRecord
  has_one :portfolio
  validates :uid, presence: true, uniqueness: true

  def registered_symbols
    portfolio.sheet.map { |s| s['symbol'] }.uniq.sort
  end
end
