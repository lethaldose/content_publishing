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

      response.should render_template 'errors/details'
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

end

