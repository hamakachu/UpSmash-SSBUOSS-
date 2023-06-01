class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy
  has_one :rule

  validates :room_name, presence: true
  
  def rule_selected?
    rule.present?
  end
end
