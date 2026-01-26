class RoomMatchingService
  class Result
    attr_reader :success, :room, :error_message

    def initialize(success:, room: nil, error_message: nil)
      @success = success
      @room = room
      @error_message = error_message
    end

    def success?
      @success
    end
  end

  # ルーム作成処理
  def self.create_room(params, user)
    room = Room.new(params)

    if room.save
      # ホストユーザーを自動的にルームに追加
      room_user = RoomUser.new(room: room, user: user)
      if room_user.save
        Result.new(success: true, room: room)
      else
        # RoomUserの保存に失敗した場合、Roomも削除
        room.destroy
        Result.new(success: false, error_message: room_user.errors.full_messages.join(", "))
      end
    else
      Result.new(success: false, error_message: room.errors.full_messages.join(", "))
    end
  end

  # ルーム参加処理
  def self.join_room(room_id, user)
    room = Room.find(room_id)

    # 既に参加済みチェック
    if room.users.include?(user)
      return Result.new(success: false, error_message: "既にこのルームに参加しています")
    end

    # 容量チェック
    if room.users.count >= 2
      return Result.new(success: false, error_message: "このルームはすでに定員に達しています")
    end

    room_user = RoomUser.new(room: room, user: user)
    if room_user.save
      Result.new(success: true, room: room)
    else
      Result.new(success: false, error_message: room_user.errors.full_messages.join(", "))
    end
  rescue ActiveRecord::RecordNotFound
    Result.new(success: false, error_message: "ルームが見つかりません")
  end
end
