class News::Market < News
  paginates_per 9

  def self.search(keyword)
    news = News::Market
    if keyword.present?
      news = news.where(['LOWER(headline) LIKE ?', 'LOWER(body) LIKE ?'].join(' OR '),
                        "%#{keyword.downcase}%",
                        "%#{keyword.downcase}%")
    end
    news
  end
end
