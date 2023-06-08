module RoomsHelper
  def user_already_joined?
    RoomUser.find_by(user_id: current_user.id) == nil
  end

  def host_user?
    current_user.id == @room.host_user_id
  end
end
