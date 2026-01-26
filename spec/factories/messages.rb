FactoryBot.define do
  factory :message do
    content { "テストメッセージ" }
    association :room
    association :user
  end
end
