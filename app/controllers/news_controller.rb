class NewsController < ApplicationController
  def index
    @news = News.search(params[:symbol]).page params[:page]
  end
end
