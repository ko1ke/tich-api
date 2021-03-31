class News::MarketsController < ApplicationController
  def index
    @news = News::Market.sort_by_newest.page params[:page]
  end
end
