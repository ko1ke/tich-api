class News::Company < News
  paginates_per 9

  def self.search(symbol)
    news = News::Company
    news = news.where(symbol: symbol) if symbol.present?
    news
  end
end
