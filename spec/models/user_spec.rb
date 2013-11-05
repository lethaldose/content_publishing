require 'spec_helper'

describe User do

  context :articles do
    it { should have_many(:articles) }
    it { should have_many(:published_articles) }
  end

  context :can_publish_article do

    it 'should not allow users to publish articles' do
      FactoryGirl.create(:user).can_publish?.should be_false
    end

    it 'should allow editor to publish articles' do
      FactoryGirl.create(:editor).can_publish?.should be_true
    end

    it 'should allow admins to publish articles' do
      FactoryGirl.create(:admin).can_publish?.should be_true
    end
  end

end

