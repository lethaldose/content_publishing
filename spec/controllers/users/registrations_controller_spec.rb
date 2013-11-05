#require 'spec_helper'

#describe  Users::RegistrationsController do

  #before(:each) do
    #User.delete_all
    #@request.env["devise.mapping"] = Devise.mappings[:user]
  #end

  #include ::ControllerMacros

  #context :create do
    #it 'should set role for the user' do
      #login_admin
      #request_params =  { 'user'=> {'email'=>'foo@bar.com', 'password'=>'password', 'password_confirmation'=>'password', 'role' => 'editor'}}

      #post :create, request_params
      #response.status.should == 302
      #User.find_by_email('foo@bar.com').is_editor?.should be_true
    #end

    #it 'should not allow to set role for unauthorized user' do
      #request_params =  { 'user'=> {'email'=>'foo@bar.com', 'password'=>'password', 'password_confirmation'=>'password', 'role' => 'editor'}}
      #post :create, request_params
      #User.all.size.should == 0
    #end
  #end
#end


