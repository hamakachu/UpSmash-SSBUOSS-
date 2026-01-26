FactoryBot.define do
  factory :room do
    sequence(:room_name) { |n| "テストルーム#{n}" }
    association :host_user, factory: :user
  end
end
