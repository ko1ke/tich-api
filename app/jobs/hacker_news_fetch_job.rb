class HackerNewsFetchJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Ex. URL: http://hn.algolia.com/api/v1/search_by_date?query=facebook&hitsPerPage=10
    connection = Faraday.new(url: 'https://hn.algolia.com')
    limit_num = 5

    Portfolio.tikers_all.each do |ticker_symbol|
      formal_name = Ticker.find_by(symbol: ticker_symbol)&.formal_name
      next if formal_name.nil?

      response = connection.get "/api/v1/search_by_date?query=#{formal_name}&hitsPerPage=#{limit_num}"
      res_boby = JSON.parse(response.body)

      hits = res_boby['hits']
      hits.each do |hit|
        headline = hit['story_title']
        body = hit['comment_text']
        link_url = hit['story_url']
        fetched_from = 'Hacker News'
        original_created_at = Time.at(hit['created_at_i'])
        original_id = hit['story_id']

        next if headline.nil? && body.nil?

        News.find_or_create_by!(headline: headline, body: body,
                                link_url: link_url, fetched_from: fetched_from, symbol: ticker_symbol,
                                original_created_at: original_created_at,
                                original_id: original_id)
      end
    end
  end
end
