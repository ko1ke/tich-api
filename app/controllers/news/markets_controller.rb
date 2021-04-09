class News::MarketsController < ApplicationController
  def index
    @news = News::Market.search(params[:keyword]).sort_by_newest.page params[:page]
  end
end
