items = @portfolio.sheet.map do |item|
  ticker = Ticker.find_by(symbol: item['symbol'])
  item.merge!(price: ticker&.price&.to_f, change: ticker&.change&.to_f)
end

json.sheet items
