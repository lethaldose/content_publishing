require 'spec_helper'

describe  UsersController do

  before(:each) do
    User.delete_all
  end

  include ::ControllerMacros

  context :unauthorized_access do

    it 'should not allow guest user' do
      request_params =  { 'user'=> {'email'=>'foo@bar.com', 'password'=>'password', 'password_confirmation'=>'password', 'role' => 'editor'}}
      post :create, request_params
      User.all.size.should == 0
    end

    it 'should not allow any other user' do
      login_user FactoryGirl.create :user
      request_params =  { 'user'=> {'email'=>'foo@bar.com', 'password'=>'password', 'password_confirmation'=>'password', 'role' => 'editor'}}
      expect {post(:create, request_params)}.to raise_error
    end
  end

  context :create do

    before :each do
      login_admin
    end

    it 'should set role for the user' do
      request_params =  { 'user'=> {'email'=>'foo@bar.com', 'password'=>'password', 'password_confirmation'=>'password', 'role' => 'editor'}}
      post :create, request_params
      response.should redirect_to(users_path)
      assigns(:user).should_not be_nil
      User.find_by_email('foo@bar.com').is_editor?.should be_true
    end

  end

  context :edit do
    before :each do
      login_admin
    end

    it 'should show user details' do
      user = FactoryGirl.create(:user)
      get :edit, {id: user.id}

      response.should be_success
      response.should render_template :edit

      assigns(:user).id.should == user.id
    end

    it 'should give error invalid id' do
      get :edit, {id: 'invalid-id'}
      response.should render_template 'errors/details'
    end
  end
end


