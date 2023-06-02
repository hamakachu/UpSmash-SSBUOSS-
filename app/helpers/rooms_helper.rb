module RoomsHelper
  def user_already_joined?
    RoomUser.find_by(user_id: current_user.id) == nil
  end
end
