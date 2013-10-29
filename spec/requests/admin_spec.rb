require 'spec_helper'

describe "Admin" do
  before do
    @admin_user = AdminUser.create(email: 'testadmin@example.com', password: 'password')
  end

  it 'logs in admin user' do
    visit new_admin_user_session_path
    fill_in 'Email', with: @admin_user.email
    fill_in 'Password', with: @admin_user.password
    click_button 'Login'
    current_path.should == admin_root_path
  end

  describe 'while logged in' do
    before do
      login_admin @admin_user
    end

    it 'creates an organization' do
      click_link 'Organizations'
      click_link 'New Organization'
      fill_in 'Name', with: 'New Organization'
      fill_in 'Phone', with: '8005551212'
      fill_in 'Max users', with: 5
      click_button 'Create Organization'
      page.should have_content 'Organization was successfully created.'
    end

    # TODO Make the role a selection
    it 'creates an organization admin' do
      @test_org = FactoryGirl.create :organization
      click_link 'Users'
      click_link 'New User'
      fill_in 'Email', with: 'newadmin@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      fill_in 'First name', with: 'New'
      fill_in 'Last name', with: 'Admin'
      select @test_org.name, from: 'Organization'
      fill_in 'Phone', with: '9991231234'
      fill_in 'Organization role', with: 'Admin'
      click_button 'Create User'
      page.should have_content 'User was successfully created.'
    end

    it 'cancels organization'
    it 'bans user'

  end

end