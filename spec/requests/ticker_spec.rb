require 'rails_helper'

RSpec.describe 'Ticker', type: :request do
  let(:ticker) { create(:ticker) }

  describe 'GET /tickers' do
    it 'return tickers' do
      ticker
      get '/tickers.json'
      aggregate_failures do
        expect(JSON.parse(response.body).first['id']).to eq ticker.id
        expect(response).to have_http_status(200)
      end
    end
  end
end
