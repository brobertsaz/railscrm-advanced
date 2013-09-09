require 'spec_helper'

describe "Opportunities", vcr: true do
  
  before do
    @user     = FactoryGirl.create :user
    @organization = FactoryGirl.create :organization
    @account  = FactoryGirl.create :account, organization: @organization.id
    @organization.users << @user
    login_as @user
  end
  
  it 'creates an opportunity' do
    click_link 'Opportunities'
    click_link 'Create New Opportunity'

    fill_in 'opportunity_opportunity_name', 		  with: 'Next Big Deal'
    select 'Big Money', 					                from: 'Account name'
    select 'New Customer', 					              from: 'Type'
    fill_in 'opportunity_amount', 	              with: '10,000'
    select 'Proposal', 							              from: 'Stage'
    select "#{@user.email}",				              from: 'Owner'
    fill_in 'opportunity_closing_date',           with: '09/11/2012'
    fill_in 'opportunity_probability', 	          with: '50%'
    fill_in 'opportunity_contact_name',	          with: 'Mister Smith'
    fill_in 'opportunity_comments', 		          with: 'Lets nail this one'
    sleep 2
    click_button 'Create Opportunity'
    page.should have_content 'New Opportunity Created'
  end

  context 'with created opportunity' do

    before do
      @opportunity = FactoryGirl.create :opportunity, owner: @user.email, account_name: @account.name, organization: @organization.id
    end

    it 'edits opportunity' do
      click_link 'Opportunities'
      within '.table-striped' do
        click_link 'edit'
      end

      fill_in 'opportunity_opportunity_name',   with: 'New Deal Name'
      fill_in 'opportunity_amount',             with: '20,000'
      click_button 'Update'
      page.should have_content 'Opportunity Successfully Updated'
    end

    it 'deletes an opportunity' do
      click_link 'Opportunities'
      click_link 'delete'
      page.should have_content 'Opportunity Deleted'
    end
  end

end