class User < ApplicationRecord
  has_one :portfolio
  has_many :favorites, dependent: :destroy
  has_many :favorite_newses, through: :favorites, source: :news
  has_many :newses

  validates :uid, presence: true, uniqueness: true

  def registered_symbols
    return nil if portfolio&.sheet.blank?

    portfolio.sheet.map { |s| s['symbol'] }.uniq.sort
  end
end
