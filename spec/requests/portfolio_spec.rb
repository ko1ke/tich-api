require 'rails_helper'

RSpec.describe 'Portfolio', type: :request do
  include_context 'login'
  let(:portfolio) { create(:portfolio, user_id: current_user.id) }
  let(:portfolio_attributes) { attributes_for(:portfolio) }
  let(:invalid_portfolio_attributes) { attributes_for(:portfolio, :invalid_sheet) }

  describe 'GET /portfolios.json' do
    it 'returns portfolios' do
      portfolio
      get '/portfolios.json'
      aggregate_failures do
        expect(JSON.parse(response.body).length).to eq 1
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /portfolios.json' do
    context 'portfolio is not created yet' do
      it 'create a portfolio' do
        aggregate_failures do
          expect do
            post '/portfolios.json', params: { "portfolio": portfolio_attributes }
          end.to change(Portfolio.all, :count).by(1)
          expect(response).to have_http_status(200)
        end
      end
    end
    context 'portfolio has been created already' do
      before do
        portfolio
      end
      it 'save a portfolio' do
        aggregate_failures do
          expect do
            post '/portfolios.json', params: { "portfolio": portfolio_attributes }
          end.to change(Portfolio.all, :count).by(0)
          expect(response).to have_http_status(200)
        end
      end
    end
    context 'sheet is invalid' do
      it 'returns error' do
        aggregate_failures do
          expect do
            post '/portfolios.json', params: { "portfolio": invalid_portfolio_attributes }
          end.to change(Portfolio.all, :count).by(0)
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
