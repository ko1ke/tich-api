class ScrapeNasdaq100TickersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    uri = 'https://en.wikipedia.org/wiki/Nasdaq-100'
    doc = Nokogiri::HTML(URI.open(uri))
    tbody = doc.xpath('//table[4]/tbody')

    tbody.xpath('.//tr').each do |tr|
      symbol = tr.xpath('.//td[2]')&.text&.strip
      formal_name = tr.xpath('.//td[1]')&.text&.strip

      next unless symbol.present? && formal_name.present?

      # remove string like "(Class C)"
      formal_name = formal_name.gsub(/\s?\(.*?\)\s?/, '')
      # remove extra string for search
      formal_name = formal_name.gsub(/,? Inc\.?\Z|,? Ltd\.?\Z|Group\Z|Corporation\Z|Corp\.?\Z|Co\.?\Z|& Co\.?\Z/, '').strip
      # it may be less noisy when searching news
      formal_name = 'Google' if formal_name == 'Alphabet'

      Ticker.find_or_create_by!(symbol: symbol,
                                formal_name: formal_name,
                                index: 'nasdaq100')
    end
  end
end
