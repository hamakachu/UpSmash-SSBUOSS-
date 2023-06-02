class StartformsController < ApplicationController
  def toppage
    
  end
  
  def index
  end

  def new
    @startform = Startform.new
  end

  def create
    @startform = Startform.new(startform_params)
    if @startform.save
      redirect_to startforms_path
    else
      render :new
    end
  end

  private
  def startform_params
    params.require(:startform).permit(:executed, :reason, :action_plan).merge(user_id: current_user.id)
  end

end
