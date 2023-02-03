require 'rails_helper'

RSpec.describe 'Ticker', type: :request do
  let(:ticker) { create(:ticker) }

  describe 'GET /tickers' do
    it 'return status 200' do
      get '/tickers.json'
      expect(response).to have_http_status(200)
    end
    it 'return tickers' do
      ticker
      get '/tickers.json'
      expect(JSON.parse(response.body).first['id']).to eq ticker.id
    end
  end
end
