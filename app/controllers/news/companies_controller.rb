class News::CompaniesController < ApplicationController
  def index
    symbol = current_user.registered_symbols if params[:symbol] == 'FAVORITES' && current_user
    symbol ||= params[:symbol] unless params[:symbol] == 'FAVORITES'
    @news = News::Company.search(symbol).sort_by_newest.page params[:page]
    @current_user = current_user
  end
end
