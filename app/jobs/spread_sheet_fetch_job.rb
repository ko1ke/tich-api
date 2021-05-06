class SpreadSheetFetchJob < ApplicationJob
  queue_as :default
  retry_on StandardError, JSON::ParserError, wait: 5.seconds, attempts: 3

  def perform(*_args)
    connection = Faraday.new('https://script.google.com') do |builder|
      builder.response :follow_redirects
      builder.adapter :net_http
    end
    response = connection.get(ENV['GAS_EXEC_PATH'])
    res_boby = JSON.parse(response.body)

    res_boby.map do |ticker_hash|
      symbol = ticker_hash['symbol']
      formal_name = ticker_hash['formalName']
      price = ticker_hash['price']
      change = ticker_hash['change']
      ticker = Ticker.find_by(symbol: symbol)
      if ticker
        ticker.update!(price: price, change: change, formal_name: formal_name)
      else
        Ticker.create!(symbol: symbol, price: price, change: change, formal_name: formal_name)
      end
    end
  end
end
