require 'rails_helper'

RSpec.describe 'RedditFetchJob', type: :job do
  include_context 'webmock_switching'
  let(:response_body) do
    { "data": { "children": [
      "data": {
        "id": '12345',
        "title": 'reddit title',
        "url": 'https://www.google.com',
        "thumbnail": 'https://en.wikipedia.org/wiki/Printed_circuit_board#/media/File:SEG_DVD_430_-_Printed_circuit_board-4276.jpg',
        "created_utc": 1_675_120_933
      }
    ] } }.to_json
  end
  let(:ticker) { create(:ticker, symbol: 'MSFT', formal_name: 'Microsoft', price: 1) }

  before do
    ActiveJob::Base.queue_adapter = :test
    WebMock.stub_request(:get, "https://www.reddit.com/search.json?q=#{ticker.formal_name}&limit=3")
           .to_return(
             body: response_body,
             status: 200,
             headers: { 'Content-Type' => 'application/json' }
           )
  end

  describe '#perform_now' do
    it 'create news' do
      expect do
        RedditFetchJob.perform_now(limit_num: 3, symbols: [ticker.symbol])
      end.to change(News.all, :count).by(1)
    end
  end

  describe '#perform_later' do
    it 'enqueue job' do
      expect do
        RedditFetchJob.perform_later
      end.to have_enqueued_job
    end
  end
end
