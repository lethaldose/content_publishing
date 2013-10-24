require 'spec_helper'

describe ArticlesController do

  login_user

  before :each do
    Article.delete_all
  end

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
  end

  context :edit do
    it 'should show article details' do
      article = FactoryGirl.create(:article)
      get :edit, {id: article.id}

      response.should be_success
      response.should render_template :edit

      assigns(:article).id.should == article.id
    end

    it 'should give error invalid id' do
      get :edit, {id: 'invalid-id'}

      response.should_not be_success
      response.status.should == 404
    end
  end
end
