FactoryGirl.define do
  factory :lead do
    sequence(:email) { |n| "lead#{n}@example.com" }
  	first_name             'Ima'
    last_name							 'Lead'
    phone									 '8005551212'
    lead_owner						 'bill@bill.com'
  end
end