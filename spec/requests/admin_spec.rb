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

    it 'creates an organization admin'
    it 'cancels organization'
    it 'bans user'

  end

end