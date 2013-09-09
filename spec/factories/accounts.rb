FactoryGirl.define do
  factory :account do
    sequence(:email) { |n| "account#{n}@microsoft.com" }
    sequence(:name) { |n| "Big Money#{n}" }
    phone           '(555) 121 6543'
    website         'microsoft.com'
    address         '123 fake st.'
  end
end