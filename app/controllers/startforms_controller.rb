class StartformsController < ApplicationController
  
  
  def index
  end

  def new
    @startform = Startform.new
  end

  def create
    @startform = Startform.create(startform_params)
    if !@startform.save
      render :new
    end
  end

  def show
    @startform = Startform.find(params[:id])
  end

  private
  def startform_params
    params.require(:startform).permit(:executed, :reason, :action_plan).merge(user_id: current_user.id)
  end

end
