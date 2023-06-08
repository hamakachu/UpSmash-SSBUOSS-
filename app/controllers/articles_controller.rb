require 'redcarpet'

class ArticlesController < ApplicationController
  before_action :find_article, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all.order("created_at DESC")
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
    @comments = Comment.where(article_id: params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :text).merge(user_id: current_user.id)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
