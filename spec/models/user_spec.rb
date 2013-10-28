require "spec_helper"

describe 'User' do
  context 'Validation' do
    it 'has a name' do
      user = FactoryGirl.build :user, :first_name => nil, :last_name => nil
      user.first_name.should_not be
      user.last_name.should_not be

      user.first_name = 'Hairy'
      user.last_name = 'Hairy'

      user.save
      user.first_name.should be
      user.last_name.should be

      user.update_attributes(:first_name => 'Balls', :last_name => 'Balls')
      user.first_name.should == 'Balls'
      user.last_name.should == 'Balls'

      user.errors.empty?.should be
    end
  end
end