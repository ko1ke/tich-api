require 'rails_helper'

RSpec.describe 'HackerNewsFetchJob', type: :job do
  include_context 'webmock_switching'
  let(:response_body) do
    { "hits": [
      "story_id": '12345',
      "story_title": 'hn title',
      "body": 'hn body',
      "story_url": 'https://www.google.com',
      "created_at_i": 1_675_775_798
    ] }.to_json
  end
  let(:ticker) { create(:ticker, symbol: 'MSFT', formal_name: 'Microsoft', price: 1) }

  before do
    WebMock.stub_request(:get, "https://hn.algolia.com/api/v1/search_by_date?hitsPerPage=3&query=#{ticker.formal_name}")
           .to_return(
             body: response_body,
             status: 200,
             headers: { 'Content-Type' => 'application/json' }
           )
  end

  describe '#perform_now' do
    it 'create news' do
      expect do
        HackerNewsFetchJob.perform_now(limit_num: 3, symbols: [ticker.symbol])
      end.to change(News.all, :count).by(1)
    end
  end

  describe '#perform_later' do
    before do
      ActiveJob::Base.queue_adapter = :test
    end
    it 'enqueue job' do
      expect do
        HackerNewsFetchJob.perform_later
      end.to have_enqueued_job
    end
  end
end
