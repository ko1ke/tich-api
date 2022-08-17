class FavoritesController < AuthController
  def create
    @favorite = Favorite.create!(favorite_params)
  end

  def destroy
    @news_favorite = Favorite.find_by(user_id: current_user.id, news_id: params[:news_id])
    @news_favorite.destroy!
  end

  private

  # Only allow a trusted parameter "white list" through.
  def favorite_params
    params.require(:favorite).permit(:news_id).merge(user_id: current_user.id)
  end
end
