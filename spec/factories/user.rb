FactoryBot.define do
  factory :user do
    sequence(:uid) { |n| "uid_#{n}" }
    sequence(:email) { |n| "test_#{n}@test.com" }

    trait :login_user do
      uid { 'uid' }
      email { 'test_another@test.com' }
    end

    trait :silver_rank do
      rank { 'silver' }
    end

    trait :gold_rank do
      rank { 'gold' }
    end
  end
end
