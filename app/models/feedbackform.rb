class Feedbackform < ApplicationRecord
  belongs_to :user

  validates :evaluation, :good, :bad, :next_action, presence: true
end
