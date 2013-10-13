require 'spec_helper'

describe "Leads" do

  before do
    @user   = FactoryGirl.create :user
    @user2  = FactoryGirl.create :user, email: 'test2@example.com', first_name: 'Jim Jones'
    @user3  = FactoryGirl.create :user, email: 'test3@example.com', first_name: 'Jim Jones II'
    @organization = FactoryGirl.create :organization
    @organization.users << @user
    @organization.users << @user2
    login_as @user
  end

  it 'should create new lead' do
    click_link 'Leads'
    click_link 'Create Lead'
    current_path.should == new_lead_path

    fill_in 'lead_first_name',  with: 'Bill'
    fill_in 'lead_last_name',   with: 'Gates'
    fill_in 'lead_phone',       with: '8005551212'
    fill_in 'lead_email',       with: 'bill@ms.com'
    fill_in 'lead_company',     with: 'Microsoft'
    fill_in 'lead_comments',    with: 'Needs ASAP'
    select "#{@user2.email}",  from: 'Lead owner'
    select 'Web Application',  from: 'Interested in'
    select 'New',              from: 'Lead status'
    select 'Web Lead',         from: 'Lead source'
    sleep 1
    click_button 'Create Lead'
    Lead.last.last_name.should == 'Gates'
    page.should have_content 'New Lead Created'
  end

  it 'adds new lead to org on creation' do
    click_link 'Leads'
    click_link 'Create Lead'
    current_path.should == new_lead_path

    fill_in 'lead_first_name',  with: 'Billy'
    fill_in 'lead_last_name',   with: 'Goats'
    fill_in 'lead_phone',       with: '8005551212'
    fill_in 'lead_email',       with: 'bill@ms.com'
    fill_in 'lead_company',     with: 'Microsoft'
    fill_in 'lead_comments',    with: 'Needs ASAP'
    select  "#{@user2.email}",  from: 'Lead owner'
    select  'Web Application',  from: 'Interested in'
    select  'New',              from: 'Lead status'
    select  'Web Lead',         from: 'Lead source'
    sleep 1
    click_button 'Create Lead'
    Lead.last.last_name.should == 'Goats'
    page.should have_content 'New Lead Created'
    @organization.leads.last.should == Lead.last
  end

  it 'notifies new lead create' do
    click_link 'Leads'
    click_link 'Create Lead'

    fill_in 'lead_first_name',  with: 'Bill'
    fill_in 'lead_last_name',   with: 'Gates'
    fill_in 'lead_phone',       with: '8005551212'
    fill_in 'lead_email',       with: 'bill2@ms.com'
    fill_in 'lead_company',     with: 'Microsoft'
    fill_in 'lead_comments',    with: 'Needs ASAP'
    select  "#{@user2.email}",  from: 'Lead owner'
    select  'Web Application',  from: 'Interested in'
    select  'New',              from: 'Lead status'
    select  'Web Lead',         from: 'Lead source'
    sleep 1
    click_button 'Create Lead'
    ActionMailer::Base.deliveries.last.to.should include @user2.email
    ActionMailer::Base.deliveries.last.body.should include 'new lead'
  end

  context 'with created lead' do

    before do
      @lead   = FactoryGirl.create :lead, first_name: 'Bill', last_name: 'Gates', phone: '8885551212', interested_in: 'ios', lead_status: 'new', lead_source: 'web', lead_owner: @user.email, organization: @organization
      @lead2  = FactoryGirl.create :lead, first_name: 'Bob', last_name: 'Marley', phone: '8005551212', interested_in: 'web_app', lead_status: 'contacted', lead_owner: @user3.email, lead_source: 'referral', email: 'bob@marley.com'
      @account = FactoryGirl.create :account, organization: @organization.id
    end

    it 'should edit a lead' do
      visit lead_path @lead
      fill_in 'lead_company', with: 'XYZ'
      select  'Contacted', from: 'Lead status'
      sleep 2
      click_button 'Update'
      page.should have_content 'Lead Updated'
    end

    it 'should show all leads belonging to org' do
      visit leads_path
      page.should have_content 'Bill Gates'
      page.should_not have_content 'Bob Marley'
    end

    it 'assigns lead to user' do
      visit lead_path @lead
      select  "#{@user2.email}", from: 'Lead owner'
      sleep 2
      click_button 'Update'
      page.should have_content 'Lead Updated'
      visit leads_path
      page.should have_content @user2.email
    end

    it 'reassigns lead' do
      visit lead_path @lead
      select  "#{@user.email}", from: 'Lead owner'
      sleep 2
      click_button 'Update'
      page.should have_content 'Lead Updated'
      visit leads_path
      page.should have_content @user.email
    end

    it 'deletes a lead', js: true do
      visit leads_path
      page.should have_content 'Bill Gates'
      click_link 'delete'
      page.driver.browser.switch_to.alert.accept
      page.should have_content 'Lead Deleted'
      page.should_not have_content 'Bill Gates'
    end

    it 'creates a note' do
      visit lead_path @lead
      fill_in 'Content', with: 'this is a note'
      select "Follow Up", from: "Note type"
      fill_in 'Due date', with: '12/25/2012'
      click_button 'Add new Note'
      page.should have_content 'Note was successfully created'
      page.should have_content 'this is a note'
    end

    it 'converts a lead' do
      visit lead_path @lead
      click_link 'Convert Lead'
      select  "#{@account.name}", from: 'Account name'
      fill_in 'Opportunity name', with: 'New Opportunity'
      select  "#{@user.email}", from: 'Opportunity owner'
      count_before = Opportunity.count
      sleep 2
      click_button 'Convert'
      Opportunity.count.should == count_before + 1
      Opportunity.last.opportunity_name.should == 'New Opportunity'
      page.should have_content 'Lead has been converted'
    end
  end

  context 'web-to-lead' do
    it 'creates web-to-lead form' do
      click_link 'Web-to-Lead Form'
      fill_in 'redirect_url',   with: '/index.html'
      check 'first_name'
      check 'last_name'
      check 'company'
      check 'email'
      check 'phone'
      check 'address'
      check 'city'
      check 'state'
      check 'zip'
      check 'comments'
      click_button 'Create Form'
      page.should have_content 'Copy the form below and use it anywhere in your website.'
    end
  end

end
