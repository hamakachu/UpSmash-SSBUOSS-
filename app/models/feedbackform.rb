class Feedbackform < ApplicationRecord
  belongs_to :user

  validates :evaluation, :good, :bad, :next_action, presence: true
  validates :my_fighter_id, :opponent_fighter_id, presence: true, numericality: {other_than: 1, message: "can't be blank"}
end
