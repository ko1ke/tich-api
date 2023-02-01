class Portfolio < ApplicationRecord
  belongs_to :user

  PROFILE_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'portfolio_schema.json').to_s
  validates :sheet, json: { schema: PROFILE_JSON_SCHEMA }
end
