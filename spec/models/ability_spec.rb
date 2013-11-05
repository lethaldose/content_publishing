require 'spec_helper'
require "cancan/matchers"

describe Ability do
  context :guest do
    let(:user){ nil }
    subject(:ability){ Ability.new(user) }

    it{ should be_able_to(:read, Article.new) }
  end

  context :reporter do
    let(:reporter){ FactoryGirl.create(:user)  }
    subject(:ability){ Ability.new(reporter) }

    it{ should be_able_to(:manage, Article.new) }
  end


  context :editor do
    let(:editor){ FactoryGirl.create(:editor)  }
    subject(:ability){ Ability.new(editor) }

    it{ should be_able_to(:manage, Article.new) }
  end


  context :admin do
    let(:admin){ FactoryGirl.create(:admin)  }
    subject(:ability){ Ability.new(admin) }

    it{ should be_able_to(:manage, :all) }
  end
end

