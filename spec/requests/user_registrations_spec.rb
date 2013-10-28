require 'spec_helper'

describe "User Registrations" do
  describe 'with free account' do

    it 'registers new user' do
      visit root_path
      click_link 'Pricing'
      page.should have_content 'Plans and Pricing'
      click_link 'Select free'
      fill_in 'Email',                  with: 'bill@example.com'
      fill_in 'Password',               with: 'password'
      fill_in 'Password confirmation',  with: 'password'
      click_button 'Sign up'
      page.should have_content 'Welcome! You have signed up successfully.'
      current_path.should == new_organization_path
    end

    describe 'new organization creation' do
      before do
        @user = FactoryGirl.create :user
      end

      it 'has no sidebar for new organization creation' do
        login_as @user
        current_path.should == new_organization_path
        page.should_not have_content 'Quick Links'
        page.should_not have_content 'Leads'
      end

      it 'registers new organization' do
        login_as @user
        current_path.should == new_organization_path
        fill_in 'Name',     with: 'XYZ'
        fill_in 'Phone',    with: '800551212'
        fill_in 'Address',  with: '123 Sesame St'
        fill_in 'City',     with: 'New York'
        select 'NY',        from: "State"
        fill_in 'Zip',      with: '12345'
        click_button 'Create Organization'
        page.should have_content 'Organization successfully created'
        current_path.should == dashboard_path
      end

    end

  end
end
