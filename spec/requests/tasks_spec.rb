require 'spec_helper'

describe 'Tasks', vcr: true do

  before do
    @user   = FactoryGirl.create :user
    @user2  = FactoryGirl.create :user, email: 'test2@example.com', first_name: 'Jim'
    @lead   = FactoryGirl.create :lead, email: 'test@test.com', first_name: 'Jenny', last_name: 'Smith'
    @organization = FactoryGirl.create :organization
    @organization.users << @user
    @organization.users << @user2
    login_as @user
  end

  it 'creates a new task' do
    click_link 'Tasks'
    click_link 'Create Task'
    fill_in 'task_due_date',        with: '09/11/2012'
    select  "#{@user2.email}",       from: 'Assigned to'
    select  'Call',                  from: 'Type'
    select  "#{@lead.email}",        from: 'For Lead'
    fill_in "task_task_name",       with: 'test task'
    click_button 'Create Task'
    Task.count.should == 1
    page.should have_content 'New Task Created'
  end

  it 'has required fields' do
    click_link 'Tasks'
    click_link 'Create Task'
    fill_in 'task_due_date',        with: '09/11/2012'
    select  "#{@user2.email}",       from: 'Assigned to'
    select  'Call',                  from: 'Type'
    select  "#{@lead.email}",        from: 'For Lead'
    click_button 'Create Task'
    Task.count.should == 0
    page.should_not have_content 'Task Updated'
  end

  it 'notifies the user they have been assigned to a task' do
    click_link 'Tasks'
    click_link 'Create Task'
    fill_in "task_task_name",       with: 'another test task'
    fill_in 'task_due_date',        with: '09/11/2012'
    select  "#{@user2.email}",       from: 'Assigned to'
    select  'Call',                  from: 'Type'
    select  "#{@lead.email}",        from: 'For Lead'
    sleep 2
    click_button 'Create Task'
    page.should have_content 'New Task Created'
    ActionMailer::Base.deliveries.last.to.should include @user2.email
    ActionMailer::Base.deliveries.last.body.should include 'call' && @lead.email
  end

  it "should allow assigning task to multiple users"

  context 'edit' do
    before do
      @task = FactoryGirl.create :task, lead_for_task: @lead.first_name, user: @user.id
    end

    it 'edits task' do
      click_link 'Tasks'
      within '.table-striped' do
        click_link 'edit'
      end
      fill_in "task_task_name",         with: 'test task 2 updated'
      fill_in 'task_due_date',          with: '09/11/2012'
      select  "#{@user2.email}",         from: 'Assigned to'
      select  'Email',                   from: 'Type'
      select  "#{@lead.email}",          from: 'For Lead'
      sleep 2
      click_button 'Update Task'
      page.should have_content 'Task Updated'
      @task.reload
      @task.task_name.should == 'test task 2 updated'
    end


    it 'notifies the user their task has changed' do
      click_link 'Tasks'
      within '.table-striped' do
        click_link 'edit'
      end
      fill_in "task_task_name",         with: 'test task 2 updated'
      fill_in 'task_due_date',          with: '09/11/2012'
      select  "#{@user2.email}",         from: 'Assigned to'
      select  'Email',                   from: 'Type'
      select  "#{@lead.email}",          from: 'For Lead'
      sleep 2
      click_button 'Update Task'
      ActionMailer::Base.deliveries.last.to.should include @user2.email
      ActionMailer::Base.deliveries.last.body.should include 'test task 2 updated' && @lead.email
    end

  end

  context 'delete' do
    before do
      @task   = FactoryGirl.create :task, lead_for_task: @lead.first_name, user: @user.id
    end

    it 'deletes task' do
      click_link 'Tasks'
      click_link 'delete'
      page.should have_content 'Task Deleted'
    end

  end
end