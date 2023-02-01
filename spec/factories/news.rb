FactoryBot.define do
  factory :news do
    sequence(:headline) { |n| "headline_#{n}" }
    sequence(:body) { |n| "body_#{n}" }
    sequence(:link_url) { |n| "link_url_#{n}" }
    sequence(:image_url) { |n| "image_url_#{n}" }
    sequence(:fetched_from) { |n| "fetched_from_#{n}" }
    symbol { Faker::Finance.ticker }
    original_created_at { DateTime.now }
    original_id { Faker::IDNumber.valid }
    type { News::Company }
  end
end
