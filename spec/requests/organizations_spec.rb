require 'spec_helper'

describe "Organizations" do
    describe "Org Admin" do
      describe 'with free account' do
        before do
          @organization = FactoryGirl.create :organization
          @admin_user = FactoryGirl.create :org_admin, organization: @organization
        end

        it 'has organization dashboard' do

        end

        it "can edit organization settings"
      end

      describe 'with paid account' do

        it "can add new user"
        it "sets user role"
        it "cannot add more than max allowed users"
      end

    end
end
