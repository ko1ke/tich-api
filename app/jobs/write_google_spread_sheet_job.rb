class WriteGoogleSpreadSheetJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Find first sheet
    json_path = File.join(Rails.root, 'gcp-config.json')
    session = GoogleDrive::Session.from_config(json_path)
    ws = session.spreadsheet_by_key(ENV['GOOGLE_SPREAD_SHEET_KEY']).worksheets[0]

    Ticker.pluck(:symbol).map.with_index do |ticker, index|
      ws[index + 1, 1] = ticker
      ws[index + 1, 2] = "=GOOGLEFINANCE(\"#{ticker}\", \"price\")"
      ws[index + 1, 3] = "=GOOGLEFINANCE(\"#{ticker}\", \"change\")"
    end

    # save
    ws.save
  end
end
