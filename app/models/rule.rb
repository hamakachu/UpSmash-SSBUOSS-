class Rule < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :format
  belongs_to :match_count
  belongs_to :voice_chat
  belongs_to :room

  with_options presence: true do
    validates :format_id, :match_count_id, :voice_chat_id, numericality: {other_than: 1, message: "can't be blank"}
  end
end
