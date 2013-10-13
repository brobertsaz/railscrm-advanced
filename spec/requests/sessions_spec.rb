require 'spec_helper'

describe "Sessions" do
  before do
    @user   = FactoryGirl.create :user
    @organization = FactoryGirl.create :organization
    @organization.users << @user
  end

  it 'logins in user' do
    visit root_path
    click_link 'Sign In'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Sign in'
    page.should have_content "Welcome to your Dashboard"
  end

end
