class NewsController < ApplicationController
  def index
    @news = News.order(original_created_at: 'DESC')
  end
end
