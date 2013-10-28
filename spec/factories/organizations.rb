FactoryGirl.define do
  sequence :name do |n|
    "New Org#{n}"
  end

  factory :organization do
    name
    phone     '8005551212'
    address   '123 Sesame st'
    city      'New York'
    state     'NY'
    zip       '12345'
    max_users 5
  end
end
