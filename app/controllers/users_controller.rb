class UsersController < ApplicationController
  before_action :find_user
  
  def show
  end 

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :twitter_id, :introduce)
  end
end
