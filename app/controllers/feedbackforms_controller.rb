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

  private

  def feedbackform_params
    params.require(:feedbackform).permit(:evaluation, :good, :bad, :next_action).merge(user_id: current_user.id)
  end

end