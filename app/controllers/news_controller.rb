class NewsController < ApplicationController
  def index
    authenticate_user
    @news = News.search(params[:keyword], current_user.id).sort_by_newest.page params[:page]
  end
end
