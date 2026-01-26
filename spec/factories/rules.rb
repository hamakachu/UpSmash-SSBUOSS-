FactoryBot.define do
  factory :rule do
    format_id { 2 }
    match_count_id { 2 }
    voice_chat_id { 2 }
    discord { "discord#1234" }
    room_code { "12345" }
    room_pass { 6789 }
    association :room
  end
end
