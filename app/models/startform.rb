class Startform < ApplicationRecord
  belongs_to :user

  validates :excuted, :reason, :action_plan, presence: true
end
