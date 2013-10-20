class UserController < ApplicationController

 def index
    if !current_user.is_admin?
      flash[:error] = 'Not authorized'
      redirect_to root_path
    end

    @users = User.all
  end
end
