class ArticlesController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:show]
  before_filter :article_exists? , only: [:show, :edit, :update]
  before_filter :can_update? , only: [:edit, :update]


  authorize_resource

  def index
    @articles = Article.editable_by(current_user)
  end

  def new
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new params[:article]
    @article.author = current_user

    if @article.save
      flash[:success] = I18n.t('articles.successfully_created')
      redirect_to articles_path
    else
      flash[:error] = I18n.t('articles.create_error')
      render action: :new
    end
  end

  def edit
    @article = @original_article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:success] = I18n.t('articles.successfully_updated')
      redirect_to articles_path
    else
      @original_article = Article.find(@article.id)
      flash[:error] = I18n.t('articles.update_error')
      render action: :edit
    end
  end

  def publish
    @article = Article.find(params[:id])

    if !current_user.can_publish?
      flash[:error] = I18n.t('articles.not_allowed_to_publish')
      edit
      render action: :edit
      return
    end

    @article.publish!(current_user)
    flash[:success] = I18n.t('articles.successfully_published')
    redirect_to articles_path
  end

  private

  def can_update?
    unless Article.find(params[:id]).can_update? current_user
      render_error(400, I18n.t("not_authorized"))
      return
    end
  end

  def article_exists?
    unless Article.exists?(params[:id])
      render_error(404, I18n.t("articles.does_not_exist"))
      return
    end
  end

end

