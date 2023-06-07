class UsersController < ApplicationController
  before_action :find_user
  
  def show
    @articles = Article.where(user_id: @user.id).order(created_at: :desc).page(params[:articles_page]).per(10)
    @startforms = Startform.where(user_id: @user.id).order(created_at: :desc).page(params[:startforms_page]).per(10)
    @feedbackforms = Feedbackform.where(user_id: @user.id).order(created_at: :desc).page(params[:feedbackforms_page]).per(10)
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
