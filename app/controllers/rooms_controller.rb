class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:show]
  
  def index
    @rooms = Room.all.order("created_at DESC")
  end

  def new
    @room = Room.new
  end

  def create
    result = RoomMatchingService.create_room(room_params, current_user)
    if result.success?
      redirect_to room_path(result.room.id)
    else
      flash.now[:alert] = result.error_message
      @room = Room.new(room_params)
      render :new
    end
  end

  def join
    result = RoomMatchingService.join_room(params[:id], current_user)
    if result.success?
      redirect_to room_path(result.room.id)
    else
      flash[:alert] = result.error_message
      redirect_to rooms_path
    end
  end

  def show
    @presenter = RoomShowPresenter.new(@room, current_user)
    @rule = Rule.new
    @message = Message.new
  end

  def destroy
    @room.destroy
    redirect_to rooms_path
  end

  private

  def set_room
    @room = Room.includes(:users, :rule, messages: { user: { image_attachment: :blob } }).find(params[:id])
  end

  def room_params
    params.require(:room).permit(:room_name, user_ids: []).merge(host_user_id: current_user.id)
  end

end
