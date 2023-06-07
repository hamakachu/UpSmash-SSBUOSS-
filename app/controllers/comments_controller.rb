class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to article_path(@comment.article_id)
    else
      @article = Article.find(params[:article_id])
      @comments = @article.comments
      render "articles/show"
    end
  end

  def destroy
    Comment.destroy(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
