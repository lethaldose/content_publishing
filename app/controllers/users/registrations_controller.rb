class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_user!, only: [:new_user, :create_new_user]
  before_filter :check_if_admin, only: [:create_new_user, :new_user]

  def create_new_user
    role = params[:user].delete(:role)

    params[:user][:role] = Role.find_by_name(role) if role

    build_resource(sign_up_params)

    if resource.save
        set_flash_message :notice, :signed_up if is_navigational_format?
        redirect_to users_path
    else
      clean_up_passwords resource
      render :new_user
    end

  end

  def new_user
    build_resource({})
    respond_with self.resource
  end

  private

  def check_if_admin
    if !user_signed_in? or !current_user.is_admin?
      response.status = 401
      raise ActiveResource::UnauthorizedAccess.new response
    end
  end
end
