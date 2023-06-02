class RulesController < ApplicationController
  before_action :set_room
  before_action :find_rule, only: [:edit, :update]

  def create
    @rule = Rule.new(rule_params)
    if @rule.save
      redirect_to @room
    else
      
    end
  end

  def edit
    
  end 

  def update
    if @rule.update(rule_params)
      redirect_to @room
    else
      render :edit
    end
  end

  private
  def find_rule
    @rule = Rule.find(params[:rule_id])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def rule_params
    params.require(:rule).permit(:format_id, :match_count_id, :voice_chat_id, :discord, :room_code, :room_pass).merge(room_id: @room.id)
  end
end
