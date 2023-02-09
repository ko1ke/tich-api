require 'rails_helper'

RSpec.describe 'FinnhubFetchJob', type: :job do
  include_context 'webmock_switching'
  let(:response_body) do
    [{
      "id": '12345',
      "headline": 'finnhub headline',
      "summary": 'finnhub summary',
      "source": 'Bloomberg',
      "url": 'https://www.google.com',
      "image": 'https://en.wikipedia.org/wiki/Printed_circuit_board#/media/File:SEG_DVD_430_-_Printed_circuit_board-4276.jpg',
      "datetime": 1_675_775_798
    }].to_json
  end
  let(:token) { 'this_is_dummy' }
  let(:ticker) { create(:ticker, symbol: 'MSFT', formal_name: 'Microsoft', price: 1) }

  before do
    ENV['FINHUB_TOKEN'] = token
  end

  describe '#perform_now' do
    context 'for commpany news' do
      let(:today) { Time.zone.now.strftime('%Y-%m-%d') }
      let(:one_week_ago) { Time.zone.now.prev_week.strftime('%Y-%m-%d') }
      before do
        WebMock.stub_request(:get, "https://finnhub.io/api/v1/company-news?symbol=#{ticker.symbol}&from=#{one_week_ago}&to=#{today}&token=#{token}")
               .to_return(
                 body: response_body,
                 status: 200,
                 headers: { 'Content-Type' => 'application/json' }
               )
      end
      it 'create company news' do
        expect do
          FinnhubFetchJob.perform_now(limit_num: 3, symbols: [ticker.symbol], klass_name: 'company')
        end.to change(News::Company.all, :count).by(1)
      end
    end
    context 'for market news' do
      before do
        WebMock.stub_request(:get, "https://finnhub.io/api/v1/news?token=#{token}")
               .to_return(
                 body: response_body,
                 status: 200,
                 headers: { 'Content-Type' => 'application/json' }
               )
      end
      it 'create maeket news' do
        expect do
          FinnhubFetchJob.perform_now(limit_num: 3, symbols: [ticker.symbol], klass_name: 'market')
        end.to change(News::Market.all, :count).by(1)
      end
    end
  end

  describe '#perform_later' do
    before do
      ActiveJob::Base.queue_adapter = :test
    end
    it 'enqueue job' do
      expect do
        FinnhubFetchJob.perform_later
      end.to have_enqueued_job
    end
  end
end
