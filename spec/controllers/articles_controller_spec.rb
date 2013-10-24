require 'spec_helper'

describe ArticlesController do

  login_user

  context :new do
    it 'should render for articles' do
      get :new
      response.should be_success
      response.should render_template :new
    end
  end

end
