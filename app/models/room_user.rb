class RoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, uniqueness: true

  validate :validate_capacity

  def validate_capacity
    if room.users.count >= 2
      errors.add(:base, "このルームはすでに定員に達しています")
    end
  end
end
