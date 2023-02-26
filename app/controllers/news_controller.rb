class NewsController < ApplicationController
  def index
    authenticate_user
    @news = News.search(params[:keyword], current_user.id).page params[:page]
  end

  def es_index
    @news = if params[:keyword].present?
              News.es_search(params[:keyword]).page params[:page]
            else
              News.all.page params[:page]
            end
    @current_user = current_user
  end
end
