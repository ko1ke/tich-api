require 'rails_helper'

RSpec.describe 'News', type: :request do
  include_context 'login'
  let(:favorite) { create(:favorite, user_id: current_user.id) }

  describe 'GET /news.json' do
    it 'returns news favored by current user' do
      f = favorite
      get '/news.json'
      aggregate_failures do
        expect(JSON.parse(response.body)['contents'].first['id']).to eq f.news.id
        expect(response).to have_http_status(200)
      end
    end
  end
end
