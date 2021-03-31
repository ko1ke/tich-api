class RedditFetchJob < ApplicationJob
  queue_as :default
  retry_on StandardError, JSON::ParserError, wait: 5.seconds, attempts: 3

  # JSON Parse Error occurs sometimes
  # JSON::ParserError (767: unexpected token at '<!doctype html><html><title>Ow! -- reddit.com</title><style>body{text-align:center;position:absolute;top:50%;margin:0;margin-top:-275px;width:100%}h2,h3{color:#555;font:bold 200%/100px sans-serif;margin:0}h3,p{color:#777;font:normal 150% sans-serif}p{font-size: 100%;font-style:italic;margin-top:2em;}</style><img src=//www.redditstatic.com/trouble-afoot.jpg alt=""><h2>all of our servers are busy right now</h2><h3>please try again in a minute</h3><p>(error code: 503)'):

  def perform(limit_num: 3, symbols: Ticker.all.pluck(:symbol))
    # Ex. URL: https://www.reddit.com/search.json?q=facebook&limit=5
    connection = Faraday.new(url: 'https://www.reddit.com')

    symbols.each do |symbol|
      formal_name = Ticker.find_by(symbol: symbol)&.formal_name
      next if formal_name.nil?

      # Need CGI escape like "Mondelēz", including non ascii string
      # NOTE: Better to use I18n.transliterate("foobar string") ?
      response = connection.get "/search.json?q=#{CGI.escape(formal_name)}&limit=#{limit_num}"
      boby = JSON.parse(response.body)
      children = boby['data']['children']
      children.each do |child|
        data = child['data']
        headline = data['title']
        link_url = data['url']
        image_url = data['thumbnail']&.include?('https:') ? data['thumbnail'] : nil
        fetched_from = 'reddit'
        original_created_at = Time.at(data['created_utc'])
        original_id = data['id']

        News.find_or_create_by!(headline: headline, link_url: link_url,
                                image_url: image_url, fetched_from: fetched_from,
                                symbol: symbol,
                                original_created_at: original_created_at,
                                original_id: original_id)
      end
    end
  end
end
