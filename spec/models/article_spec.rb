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

    it 'should have published state' do
      article = Article.new
      article.publish
      article.should be_published
    end
  end

end

