class UsersController < ApplicationController

 authorize_resource
 before_filter :user_exists? , only: [:edit, :update]

 def index
    if !current_user.is_admin?
      flash[:error] = I18n.t('not_authorized')
      redirect_to root_path
    end

    @users = User.all
  end

  def create
    role = get_role_from_params
    @user = User.new params[:user]
    @user.role = role

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

  def update
    params[:user].delete(:email)
    @user = User.find(params[:id])
    @user.role = get_role_from_params
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:success] = I18n.t('user.successfully_updated')
      redirect_to users_path
    else
      flash[:error] = I18n.t('user.update_error')
      render action: :edit
    end
  end

  private

  def get_role_from_params
    role = params[:user].delete(:role)
    Role.find_by_name(role) if role
  end

  def user_exists?
    unless User.exists?(params[:id])
      render_error(404, I18n.t("user.does_not_exist"))
      return
    end
  end
end
