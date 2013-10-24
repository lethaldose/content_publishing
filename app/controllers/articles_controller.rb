class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end

  def new
  end

  def create
    article = Article.new params[:article]
    article.save!
    redirect_to articles_path
  end
end
