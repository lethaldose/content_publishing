require 'spec_helper'

describe ArticlesController do

  include ::ControllerMacros

  before :each do
    login_user
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

      response.should render_template 'errors/details'
    end
  end

  context :show do
    it 'should render edit page' do
      article = FactoryGirl.create(:article)
      get :show, {id: article.id}

      response.should be_success
      response.should render_template :edit
    end
  end

  context :update do
    it 'should update article name and content' do
      article = FactoryGirl.create(:article, name: 'orig_name')

      request_params = {id: article.id, article: {name: 'foo', content: 'bar'}}
      put :update, request_params


      assigns(:article).should_not be_nil
      assigns(:article).id.should == article.id

      updated_article = Article.find_by_name('foo')
      updated_article.content.should == 'bar'

      response.should redirect_to articles_path
      flash[:success].should == I18n.t('articles.successfully_updated')
    end


    it 'should not update published records' do
      article = FactoryGirl.create(:article)
      article.publish!

      request_params = {id: article.id, article: {name: 'foo', content: 'bar'}}
      put :update, request_params

      response.should render_template :edit
      flash[:error].should == I18n.t('articles.update_error')
    end

    it 'should handle update errors' do
      orig_name = 'Orignal'
      article = FactoryGirl.create(:article, name: orig_name)

      request_params = {id: article.id, article: {name: ''}}
      put :update, request_params

      assigns(:original_article).name.should == orig_name

      updated_article = Article.find(article.id)
      updated_article.name.should_not be_empty

      response.should render_template :edit
      flash[:error].should == I18n.t('articles.update_error')
    end
  end

  context :publish do

    before :each do
      login_admin
    end

    it 'should publish the article' do
      article = FactoryGirl.create(:article)
      article.should be_draft

      request_params = {id: article.id}
      put :publish, request_params

      response.should redirect_to articles_path
      flash[:success].should == I18n.t('articles.successfully_published')

      article.reload
      article.should be_published
    end
  end

  context :index do

    it 'should show articles for current logged in user' do

      author = FactoryGirl.create(:user)
      login_user author

      FactoryGirl.create(:article, author: author)
      FactoryGirl.create(:article, author: author)
      FactoryGirl.create(:article)

      get :index
      response.should be_ok

      articles = assigns(:articles)
      articles.should have(2).items
      articles.first.author.should  == author
      articles[1].author.should  == author
    end

    it 'should show all articles to editor' do
      editor = FactoryGirl.create(:user, role: Role.find_by_name('editor'))
      login_user editor

      FactoryGirl.create(:article)
      FactoryGirl.create(:article)

      get :index
      response.should be_ok

      articles = assigns(:articles)
      articles.should have(2).items
    end

    it 'should sort descending on updated_at attribute' do
      author = FactoryGirl.create(:user)
      login_user author

      article1 = FactoryGirl.create(:article, author: author)
      article2 = FactoryGirl.create(:article, author: author)

      get :index
      response.should be_ok

      articles = assigns(:articles)
      articles[0].should == article2
      articles[1].should == article1
    end
  end
end

