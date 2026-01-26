FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "testuser#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    introduce { "よろしくお願いします" }
  end
end
