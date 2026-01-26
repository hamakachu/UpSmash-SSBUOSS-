class RoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, uniqueness: { scope: :room_id, message: "は既にこのルームに参加しています" }

  validate :validate_capacity

  def validate_capacity
    if room.users.count >= 2
      errors.add(:base, "このルームはすでに定員に達しています")
    end
  end

end
