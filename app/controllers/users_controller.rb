class UsersController < ApplicationController

 before_filter :check_if_admin

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

  private

  def check_if_admin
    if !user_signed_in? or !current_user.is_admin?
      response.status = 401
      raise ActiveResource::UnauthorizedAccess.new response
    end
  end
end
