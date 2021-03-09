class ScrapeSp500TickersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    uri = 'http://en.wikipedia.org/wiki/List_of_S%26P_500_companies'
    doc = Nokogiri::HTML(URI.open(uri))
    tbody = doc.at_xpath('//tbody')
    tbody.xpath('.//tr').each do |tr|
      symbol = tr.xpath('.//td[1]').text.chomp
      formal_name = tr.xpath('.//td[2]').text.chomp
      next unless symbol.present? && formal_name.present?

      Ticker.find_or_create_by!(symbol: symbol,
                                formal_name: formal_name,
                                index: 'sp500')
    end
  end
end
