# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
  name      'New Org'
  phone     '8005551212'
  address   '123 Sesame st'
  city      'New York'
  state     'NY'
  zip       '12345'
  end
end
