require 'spec_helper'

describe "ContactForm" do
  it "delivers a valid message" do
    visit root_path
    click_link "Contact Us"
    fill_in 'Name', :with => 'Test User'
    fill_in 'Email', :with => 'test@example.com'
    fill_in 'Message', :with => 'What a great website.'
    click_button 'Send message'
    page.body.should have_content('Thank you for your message')
    ActionMailer::Base.deliveries.last.to.should include('broberts_az@yahoo.com')
    ActionMailer::Base.deliveries.last.from.should include('test@example.com')
  end

  it "does not deliver a message with a missing email" do
    visit root_path
    click_link "Contact Us"
    fill_in 'Name', :with => 'Test User'
    fill_in 'Message', :with => 'What a great website.'
    click_button 'Send message'
    page.body.should have_content("Email can't be blank")
  end

  it "does not deliver spam" do
    pending "This does not appear to render the proper source but passes in a browser."
    visit root_path
    click_link "Contact Us"
    fill_in 'Name', :with => 'Test User'
    fill_in 'Email', :with => 'spammer@spammyjunk.com'
    fill_in 'Message', :with => "All the junk you'll never need."
    fill_in 'Nickname', :with => 'Want to buy some boots?'
    click_button 'Send message'
    page.body.should have_content('this message appears to be spam')
  end
end