class UsersController < ApplicationController

 def index
    if !current_user.is_admin?
      flash[:error] = I18n.t('not_authorized')
      redirect_to root_path
    end

    @users = User.all
  end
end
