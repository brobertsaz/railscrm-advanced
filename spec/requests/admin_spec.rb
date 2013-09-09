# require 'spec_helper'

# describe "Admin", vcr: true do

#   before do
#     @organization = FactoryGirl.create :organization
#     @admin = FactoryGirl.create :admin_user
#     login_as @admin
#   end

#   it 'shows admin page' do
#     current_path.should == admin_path
#   end

#   it 'creates organization' do
#     click_link 'Create New Organization'
#     fill_in 'Name',     with: 'New Org'
#     fill_in 'Phone',    with: '8005551212'
#     fill_in 'Address',  with: '123 Sesame'
#     fill_in 'City',     with: 'New York'
#     fill_in 'State',    with: 'NY'
#     fill_in 'Zip',      with: '12345'
#     click_button 'Create Organization'
#     page.should have_content 'Organization successfully created'
#     page.should have_content 'New Org'
#   end

#   it 'edits organization' do
#     click_link 'edit'
#     fill_in 'Name', with: 'New Name'
#     click_button 'Update'
#     page.should have_content 'Organization successfully updated'
#   end

#   it 'deletes organization', js: true do
#     click_link 'delete'
#     page.driver.browser.switch_to.alert.accept
#     page.should have_content 'Organization Deleted'
#     page.should_not have_content 'New Name'
#   end

#   it 'shows organization' do
#     click_link 'New Org'
#     page.should have_content 'View Organization'
#   end

#   it 'adds user to organization' do
#     visit admin_organization_path(@organization)
#     click_link 'Add Member'
#     fill_in 'First name',            with: 'Super'
#     fill_in 'Last name',             with: 'User'
#     fill_in 'Email',                 with: 'org_test@example.com'
#     fill_in 'Password',              with: 'password'
#     fill_in 'Password confirmation', with: 'password'
#     select 'User',                  from: 'Organization role'
#     click_button 'Create User'
#     page.should have_content 'Successfully added new user'
#   end

#     context 'with users' do
#       before do
#         @user = FactoryGirl.create :user
#         @organization.users << @user
#         visit admin_organization_path(@organization)
#       end

#       it 'lists users' do
#         page.should have_content 'Test User'
#       end

#       it 'edits user' do
#         click_link 'edit'
#         select 'Admin', from: 'Organization role'
#         click_button 'Update User'
#         page.should have_content 'Successfully updated user'
#       end

#       it 'deletes user', js: true do
#         click_link 'delete'
#         page.driver.browser.switch_to.alert.accept
#         page.should have_content 'Successfully deleted user'
#         page.should_not have_content 'Test User'
#       end
#     end

# end
