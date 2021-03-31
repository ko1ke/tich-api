class News::CompaniesController < ApplicationController
  def index
    @news = News::Company.search(params[:symbol]).sort_by_newest.page params[:page]
  end
end
