require 'spec_helper'

describe Role do

  it 'should assert on roles' do
    Role.new(name:'admin').is_admin?.should be_true
    Role.new(name:'reporter').is_reporter?.should be_true
    Role.new(name:'editor').is_editor?.should be_true
    Role.new.is_editor?.should be_false
  end

end

