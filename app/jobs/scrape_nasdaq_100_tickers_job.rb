class ScrapeNasdaq100TickersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    uri = 'https://en.wikipedia.org/wiki/Nasdaq-100'
    doc = Nokogiri::HTML(URI.open(uri))
    tbody = doc.xpath('//table[4]/tbody')

    tbody.xpath('.//tr').each do |tr|
      symbol = tr.xpath('.//td[1]').text.chomp
      formal_name = tr.xpath('.//td[2]').text.chomp
      next unless symbol.present? && formal_name.present?

      Ticker.find_or_create_by!(symbol: symbol,
                                formal_name: formal_name,
                                index: 'nasdaq100')
    end
  end
end
