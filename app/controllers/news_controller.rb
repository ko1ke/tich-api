class NewsController < ApplicationController
  def index
    @news = News.order(original_created_at: 'DESC').page params[:page]
  end
end
