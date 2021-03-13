class ScrapeSp500TickersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    uri = 'http://en.wikipedia.org/wiki/List_of_S%26P_500_companies'
    doc = Nokogiri::HTML(URI.open(uri))
    tbody = doc.at_xpath('//tbody')
    tbody.xpath('.//tr').each do |tr|
      symbol = tr.xpath('.//td[1]')&.text&.strip
      formal_name = tr.xpath('.//td[2]')&.text&.strip

      next unless symbol.present? && formal_name.present?

      # remove string like "(Class C)"
      formal_name = formal_name.gsub(/\s?\(.*?\)\s?/, '')
      # remove extra string for search
      formal_name = formal_name.gsub(/,? Inc\.?\Z|,? Ltd\.?\Z|Group\Z|Corporation\Z|Corp\.?\Z|Co\.?\Z|& Co\.?\Z/,
                                     '').strip
      # it may be less noisy when searching news
      formal_name = 'Google' if formal_name == 'Alphabet'

      Ticker.find_or_create_by!(symbol: symbol,
                                formal_name: formal_name,
                                index: 'sp500')
    end
  end
end
