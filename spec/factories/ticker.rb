FactoryBot.define do
  factory :ticker do
    symbol { Faker::Finance.ticker }
    formal_name { Faker::Name.name }
    price { Faker::Number.decimal(l_digits: 2) }
    change { Faker::Number.decimal(l_digits: 2) }
  end
end
