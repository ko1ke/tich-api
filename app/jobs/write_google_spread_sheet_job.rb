class WriteGoogleSpreadSheetJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Find first sheet
    json_path = File.join(Rails.root, 'gcp-config.json')
    session = GoogleDrive::Session.from_config(json_path)
    sheet = session.spreadsheet_by_key(ENV['GOOGLE_SPREAD_SHEET_KEY'])
    old_ws = sheet.worksheets[0]

    # Create new sheet and input tickers and GOOGLEFINANCE func
    new_ws = sheet.add_worksheet(Time.current)
    Ticker.pluck(:symbol).uniq.map.with_index do |ticker, index|
      new_ws[index + 1, 1] = ticker
      new_ws[index + 1, 2] = "=GOOGLEFINANCE(\"#{ticker}\", \"price\")"
      new_ws[index + 1, 3] = "=GOOGLEFINANCE(\"#{ticker}\", \"change\")"
    end

    # save
    old_ws.delete
    new_ws.save
  end
end
