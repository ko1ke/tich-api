class News::Company < News
  def self.search(symbol)
    news = News::Company
    news = news.where(symbol: symbol) if symbol.present?
    news
  end
end
