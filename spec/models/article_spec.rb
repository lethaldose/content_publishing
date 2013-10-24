require 'spec_helper'

describe Article do

  context :validation do
    it {should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  context :new do
    it 'should have default draft state' do
      Article.new.should be_draft
    end
  end

  context :publish do
    it 'should have published state' do
      article = FactoryGirl.create(:article)
      article.publish!
      article.should be_published
    end

    it 'should not allow update of published records' do
      article = FactoryGirl.create(:article)
      article.publish!
      article.name = 'random-foo'
      article.save.should be_false
      article.errors[:state].should_not be_empty
    end
  end

end

