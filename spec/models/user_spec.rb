require 'spec_helper'

describe User do

  context :articles do
    it { should have_many(:articles) }
  end
end

