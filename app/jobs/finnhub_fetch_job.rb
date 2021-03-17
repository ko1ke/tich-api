class FinnhubFetchJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Ex. URL: https://finnhub.io/api/v1/company-news?symbol=AAPL&from=2021-03-01&to=2021-03-09&token=[TOKEN]

    # TODO: Timer to avoid Limit 60 API calls/minute (1 call/1 sec)
    connection = Faraday.new(url: 'https://finnhub.io')
    limit_num = 5
    today = Time.new.strftime('%Y-%m-%d')
    one_week_ago = Time.new.prev_week.strftime('%Y-%m-%d')

    Portfolio.tikers_all.each do |ticker_symbol|
      timer = Timer.new(1)
      symbol = Ticker.find_by(symbol: ticker_symbol)&.symbol
      next if symbol.nil?

      response = connection.get "/api/v1/company-news?symbol=#{symbol}&from=#{one_week_ago}&to=#{today}&token=#{ENV['FINHUB_TOKEN']}"
      res_boby = JSON.parse(response.body)

      res_boby[0..limit_num - 1].each do |news|
        headline = news['headline']
        body = news['summary']
        link_url = news['url']
        image_url = news['image']
        fetched_from = 'Finnhub'
        original_created_at = Time.at(news['datetime'])
        original_id = news['id']

        News.find_or_create_by!(headline: headline, body: body,
                                link_url: link_url,
                                image_url: image_url,
                                fetched_from: fetched_from, symbol: ticker_symbol,
                                original_created_at: original_created_at,
                                original_id: original_id)
        timer.set_time_remaining
        sleep(timer.time_remaining)
      end
    end
  end
end
