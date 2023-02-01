FactoryBot.define do
  factory :favorite do
    association :user
    association :news
  end
end
