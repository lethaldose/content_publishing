require 'spec_helper'

describe Article do

  context :validation do
    it {should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  context :new do
    it 'should have default draft state' do
      Article.new.state.should == ArticleState::DRAFT
    end
  end

end

