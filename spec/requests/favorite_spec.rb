require 'rails_helper'

RSpec.describe 'Favorite', type: :request do
  include_context 'login'
  let(:news) { create(:news) }

  describe 'POST /favorites.json' do
    it 'create a favorite' do
      expect do
        post '/favorites.json', params: { "favorite": { "news_id": news.id } }
      end.to change(Favorite.all, :count).by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /favorites' do
    it 'delete a favorite' do
      favorite = create(:favorite, user_id: current_user.id)
      expect do
        delete "/favorites/#{favorite.news.id},json", params: { "news_id": favorite.news.id }
      end.to change(Favorite.all, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
