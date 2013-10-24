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

  context :create do
    it 'should create new article' do
      name = 'Part-1'
      request_params = {article: {name: name, content: 'black sheep'}}

      post :create, request_params

      assigns(:article).should_not be_nil
      new_article = Article.find_by_name(name)
      assigns(:article).id.should == new_article.id
      response.should redirect_to articles_path
      flash[:success].should == I18n.t('articles.successfully_created')
    end

    it 'should give error if article with same name exisits' do
      name = 'Part-2'
      FactoryGirl.create(:article, name: name)
      request_params = {article: {name: name, content: 'black sheep'}}

      post :create, request_params

      assigns(:article).should_not be_nil
      assigns(:article).errors[:name].should_not be_empty
      Article.all.size.should == 1
      response.should render_template :new
      flash[:error].should == I18n.t('articles.create_error')
    end

    it 'should allow to create article with special characters' do

    end
  end
end
