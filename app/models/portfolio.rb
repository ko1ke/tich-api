class Portfolio < ApplicationRecord
  belongs_to :user

  SHEET_SCHEMA = {
    type: 'array',
    items: {
      allOf: [
        type: 'object',
        required: %w[symbol note targetPrice],
        properties: {
          symbol: { type: 'string' },
          note: { type: 'string' },
          targetPrice: { type: %w[number string] }
        }
      ]
    }
  }.freeze
  validates :sheet, json: { schema: SHEET_SCHEMA }
end
