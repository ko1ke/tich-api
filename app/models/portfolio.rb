class Portfolio < ApplicationRecord
  belongs_to :user, foreign_key: :user_id

  PROFILE_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'portfolio_schema.json').to_s
  validates :sheet, json: { schema: PROFILE_JSON_SCHEMA }

  def self.tikers_all
    all_sheet = Portfolio.pluck(:sheet).flatten
    all_sheet.map { |sheet| sheet['ticker'] }.uniq
  end
end
