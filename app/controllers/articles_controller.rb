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

  def edit
    unless Article.exists?(params[:id])
      render_error(404, I18n.t("articles.does_not_exist"))
      return
    end

    @article = Article.find(params[:id])
  end

  def update

  end
end
