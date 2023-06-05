class Startform < ApplicationRecord
  belongs_to :user

  validates :reason, :action_plan, presence: true
end
