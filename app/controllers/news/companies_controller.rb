class News::CompaniesController < ApplicationController
  def index
    symbol = current_user.registered_symbols if params[:symbol] == 'FAVORITES'
    symbol ||= params[:symbol]
    @news = News::Company.search(symbol).sort_by_newest.page params[:page]
  end
end
