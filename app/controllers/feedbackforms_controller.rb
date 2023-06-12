class FeedbackformsController < ApplicationController
  before_action :authenticate_user!

  def new
    @feedbackform = Feedbackform.new
  end

  def create
    @feedbackform = Feedbackform.create(feedbackform_params)
    if !@feedbackform.save
      render :new
    end
  end

  def show
    @feedbackform = Feedbackform.find(params[:id])
  end

  private

  def feedbackform_params
    params.require(:feedbackform).permit(:evaluation, :good, :bad, :next_action, :my_fighter_id, :opponent_fighter_id).merge(user_id: current_user.id)
  end

end
