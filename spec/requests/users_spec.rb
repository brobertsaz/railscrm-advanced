require 'spec_helper'

describe "User Dashboard", vcr: true do

  before do
    @user   = FactoryGirl.create :user
    @lead   = FactoryGirl.create :lead, first_name: 'Bill', last_name: 'Gates', phone: '8885551212', interested_in: 'ios', lead_status: 'new', lead_source: 'web', lead_owner: @user.email
    @task = FactoryGirl.create :task, lead_for_task: @lead.first_name, assigned_to: @user.email
    @organization = FactoryGirl.create :organization
    @organization.users << @user
    login_as @user
  end

  it 'has user dashboard' do
    page.should have_content "Welcome to your Dashboard"
  end

  it 'has quick links' do
    page.should have_content 'New Lead'
    page.should have_content 'New Task'
    page.should have_content 'New Contact'
    page.should have_content 'New Account'
    page.should have_content 'New Opportunity'
  end

  it 'links to new lead' do
    click_link 'New Lead'
    page.should have_content 'Lead Info'
  end

  it 'links to new task' do
    click_link 'New Task'
    page.should have_content 'Create New Task'
  end

  it 'links to new contact' do
    click_link 'New Contact'
    page.should have_content 'First name'
  end

  it 'links to new account' do
    click_link 'New Account'
    page.should have_content 'Name'
  end

  it 'links to new opportunity' do
    click_link 'New Opportunity'
    page.should have_content 'Create New Opportunity'
  end

  it 'has additional settings'do
    page.should have_content 'Settings'
  end

  it 'shows leads assigned' do
    page.should have_content @lead.full_name
    page.should have_content @lead.company
    page.should have_content @lead.lead_status.to_s.capitalize
    page.should have_content @lead.created_at.to_date
  end

  it 'shows tasks assigned' do
    page.should have_content @task.task_name.titleize
    page.should have_content @task.due_date
    page.should have_content @task.task_type.titleize
    page.should have_content @task.lead_for_task.titleize
  end

  it 'can create its profile' do
    click_link 'Profile'
    fill_in 'First name', with: 'Bill'
    fill_in 'Last name', with: 'Gates'
    fill_in 'Phone', with: '8001231234'
    click_button 'Save'
    page.should have_content 'User has been successfully updated'
  end

  it 'can set notification settings'

end
