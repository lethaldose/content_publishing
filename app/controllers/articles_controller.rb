class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
  end

  def create
    @article = Article.new params[:article]
    if @article.save
      flash[:success] = I18n.t('articles.successfully_created')
      redirect_to articles_path
    else
      flash[:error] = I18n.t('articles.create_error')
      render action: :new
    end
  end

end
