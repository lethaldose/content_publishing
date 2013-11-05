module ControllerMacros
  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    admin = FactoryGirl.create(:admin)
    sign_in admin
    admin
  end

  def login_user user=nil
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = user || FactoryGirl.create(:user)
    sign_in user
    user
  end
end
