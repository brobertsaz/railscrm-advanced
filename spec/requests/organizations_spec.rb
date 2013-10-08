require 'spec_helper'

describe "Organizations" do
    describe "Org Admin" do
      before do
        @organization = FactoryGirl.create :organization
        @admin_user = FactoryGirl.create :org_admin, organization: @organization
      end

      it 'has organization dashboard'
      it "can add new user"
      it "sets user role"
      it "can edit organization settings"
      it "cannot add more than max allowed users"
    end
end
