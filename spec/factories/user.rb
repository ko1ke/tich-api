FactoryBot.define do
  factory :user do
    sequence(:uid) { |n| "uid_#{n}" }
    sequence(:email) { |n| "test_#{n}@test.com" }

    trait :another do
      email { 'test_another@test.com' }
    end
  end
end
