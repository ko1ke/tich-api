require 'rails_helper'

RSpec.describe 'SpreadSheetFetchJob', type: :job do
  let(:exec_path) { 'this_is_dummy' }
  let(:response_body) { [{ "symbol": 'MSFT', "formalName": 'Microsoft', "price": 200, 'change': 2 }].to_json }

  before do
    ActiveJob::Base.queue_adapter = :test

    WebMock.enable!
    ENV['GAS_EXEC_PATH'] = exec_path
    WebMock.stub_request(:get, "https://script.google.com/#{exec_path}")
           .to_return(
             body: response_body,
             status: 200,
             headers: { 'Content-Type' => 'application/json' }
           )
  end
  after do
    WebMock.disable!
  end

  describe '#perform_now' do
    let(:ticker) { create(:ticker, symbol: 'MSFT', formal_name: 'Microsoft', price: 1) }

    context 'ticker symbol is not registered yet' do
      it 'create tickers' do
        expect do
          SpreadSheetFetchJob.perform_now
        end.to change(Ticker.all, :count).by(1)
      end
    end
    context 'ticker symbol has been registered already' do
      it 'update tickers' do
        t = ticker
        aggregate_failures do
          expect do
            SpreadSheetFetchJob.perform_now
          end.to change(Ticker.all, :count).by(0)
          expect(Ticker.first.symbol).to eq(t.symbol)
          expect(Ticker.first.price).to eq(200)
          expect(Ticker.first.change).to eq(2)
        end
      end
    end
  end

  describe '#perform_later' do
    it 'enqueue job' do
      expect do
        SpreadSheetFetchJob.perform_later
      end.to have_enqueued_job
    end
  end
end
