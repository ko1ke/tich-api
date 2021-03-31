class HackerNewsFetchJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(limit_num: 3, symbols: Ticker.all.pluck(:symbol))
    # Ex. URL: http://hn.algolia.com/api/v1/search_by_date?query=facebook&hitsPerPage=10
    connection = Faraday.new(url: 'https://hn.algolia.com')

    symbols.each do |symbol|
      formal_name = Ticker.find_by(symbol: symbol)&.formal_name
      next if formal_name.nil?

      # Need CGI escape like "Mondelēz", including non ascii string
      response = connection.get "/api/v1/search_by_date?query=#{CGI.escape(formal_name)}&hitsPerPage=#{limit_num}"
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
                                link_url: link_url, fetched_from: fetched_from, symbol: symbol,
                                original_created_at: original_created_at,
                                original_id: original_id)
      end
    end
  end
end
