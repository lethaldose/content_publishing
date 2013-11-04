require 'spec_helper'

describe HomeController do

  include ::ControllerMacros

  before :each do
    Article.destroy_all
  end

  context :reporter do

    before :each do
      @user = FactoryGirl.create :user
      login_user @user
    end

    it 'should give count of published articles' do
      FactoryGirl.create(:article)
      FactoryGirl.create(:article, author: @user, state: ArticleState::PUBLISHED)
      get :index
      assigns(:published_articles_count).should == 1
      assigns(:draft_articles_count).should == 0
    end

    it 'should give count of draft articles' do
      FactoryGirl.create(:article)
      FactoryGirl.create(:article, author: @user)
      FactoryGirl.create(:article, author: @user, state: ArticleState::PUBLISHED)
      get :index
      assigns(:draft_articles_count).should == 1
      assigns(:published_articles_count).should == 1
    end
  end
end

