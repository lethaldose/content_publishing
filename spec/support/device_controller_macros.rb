module ControllerMacros
  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin)
  end

  def login_user user=nil
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = user || FactoryGirl.create(:user)
    sign_in user
  end
end
