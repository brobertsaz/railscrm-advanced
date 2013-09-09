FactoryGirl.define do
  factory :contact do
    sequence(:email) { |n| "user#{n}@microsoft.com" }
  	first_name             'Ima'
    last_name							 'Contact'
    phone									 '8005551212'
   end
end