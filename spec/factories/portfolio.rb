FactoryBot.define do
  factory :portfolio do
    sheet do
      [
        {
          "symbol": Faker::Finance.ticker,
          "note": Faker::Lorem.sentence,
          "targetPrice": Faker::Number.decimal(l_digits: 2)
        }
      ]
    end
    association :user

    trait :blank_sheet do
      sheet { [] }
    end

    trait :invalid_sheet do
      sheet do
        [
          {
            'targetPrice' => 'str'
          }
        ]
      end
    end
  end
end
