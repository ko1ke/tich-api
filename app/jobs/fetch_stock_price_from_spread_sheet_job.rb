class FetchStockPriceFromSpreadSheetJob < ApplicationJob
  queue_as :default
  retry_on StandardError, JSON::ParserError, wait: 5.seconds, attempts: 3

  def perform(*_args)
    # Find first sheet
    json_path = File.join(Rails.root, 'gcp-config.json')
    session = GoogleDrive::Session.from_config(json_path)
    sheet = session.spreadsheet_by_key(ENV['GOOGLE_SPREAD_SHEET_KEY'])
    old_ws = sheet.worksheets[0]

    # Create new sheet and input tickers and GOOGLEFINANCE func
    new_ws = sheet.add_worksheet(Time.current)
    write_work_sheet(new_ws)

    # Renew the work sheet
    old_ws.delete
    new_ws.save
    new_ws.reload

    # Update price and change columns on tickers
    update_tickers(new_ws)
  end

  private

  def write_work_sheet(work_sheet)
    Ticker.pluck(:symbol).uniq.map.with_index do |ticker, index|
      work_sheet[index + 1, 1] = ticker
      work_sheet[index + 1, 2] = "=GOOGLEFINANCE(\"#{ticker}\", \"price\")"
      work_sheet[index + 1, 3] = "=GOOGLEFINANCE(\"#{ticker}\", \"change\")"
    end
  end

  def update_tickers(work_sheet)
    last_row = work_sheet.num_rows
    (1..last_row).each do |index|
      symbol = work_sheet[index, 1]
      price = work_sheet[index, 2]
      change = work_sheet[index, 3]
      ticker = Ticker.find_by(symbol: symbol)
      ticker&.update!(price: price, change: change)
    end
  end
end
