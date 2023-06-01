class RoomsController < ApplicationController
  
  
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def join
    @room_user = RoomUser.new
    @room_user.room_id = params[:id]
    @room_user.user_id = current_user.id
    if @room_user.save
      redirect_to room_path
    else
      # 参加不可時の処理を記述
    end
  end

  def show
    @room = Room.find(params[:id])
    @rule = Rule.new
    @message = Message.new
    @messages = @room.messages.includes(:user)
  end

  private

  def room_params
    params.require(:room).permit(:room_name, user_ids: []).merge(host_user_id: current_user.id)
  end

end
