class News < ApplicationRecord
  paginates_per 15

  def self.search(symbol)
    news = News.order(original_created_at: 'DESC')
    news = news.where(symbol: symbol) if symbol.present?
    news
  end
end
