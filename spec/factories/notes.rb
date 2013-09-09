# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    note_type  'Call Back'
    due_date   Date.today + 14
  end
end
