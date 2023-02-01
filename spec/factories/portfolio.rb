FactoryBot.define do
  factory :portfolio do
    sheet do
      [
        {
          "symbol": Faker::Finance.ticker,
          "targetPrice": Faker::Number.decimal(l_digits: 2),
          "note": Faker::Lorem.sentence
        }
      ]
    end
    association :user

    trait :blank_sheet do
      sheet { [] }
    end
  end
end
