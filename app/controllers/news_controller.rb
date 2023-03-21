class NewsController < ApplicationController
  include FeatureFlaggable

  def index
    authenticate_user
    @news = News.search(params[:keyword], current_user.id).page params[:page]
  end

  def es_index
    render json: { message: 'cannnot access' }, status: :forbidden unless elastic_search_flag_enabled?

    @news = if params[:keyword].present?
              News.es_search(params[:keyword],
                             params[:type],
                             params[:operator])
                  .page params[:page]
            else
              News.all.page params[:page]
            end
    @current_user = current_user
  end
end
