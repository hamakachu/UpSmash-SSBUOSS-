class MessageChannel < ApplicationCable::Channel
  def subscribed
    @room = Room.find(params[:room_id]) # 追記
    stream_for @room

    stream_from "message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
