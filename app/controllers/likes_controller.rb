class LikesController < ApplicationController
  def create
    like = current_user.likes.build(article_id: params[:article_id])
    like.save
    redirect_to article_path(like.article_id)
  end

  def destroy
    like = Like.find_by(article_id: params[:article_id] ,user_id: current_user.id)
    like.destroy
    redirect_to article_path
  end
end
