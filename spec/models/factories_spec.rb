require 'spec_helper'

describe 'validate FactoryGirl factories' do
  FactoryGirl.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      it "is valid" do
        create(factory.name)
        obj = build(factory.name)
        expect(obj).to be_valid
      end
    end
  end
end
