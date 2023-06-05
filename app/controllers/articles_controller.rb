require 'redcarpet'

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :text).merge(user_id: current_user.id)
  end
end
