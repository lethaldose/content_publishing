class UsersController < ApplicationController

 authorize_resource
 before_filter :user_exists? , only: [:edit]

 def index
    if !current_user.is_admin?
      flash[:error] = I18n.t('not_authorized')
      redirect_to root_path
    end

    @users = User.all
  end

  def create
    role = params[:user].delete(:role)
    @user = User.new params[:user]
    @user.role = Role.find_by_name(role) if role

    if @user.save
      flash[:success] = I18n.t('articles.successfully_created')
      redirect_to users_path
    else
      render :new
    end

  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
  private

  def user_exists?
    unless User.exists?(params[:id])
      render_error(404, I18n.t("user.does_not_exist"))
      return
    end
  end
end
