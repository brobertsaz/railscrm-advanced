FactoryGirl.define do
  factory :task do
  	task_name					'Call Lead'
  	due_date					'asap'
  	assigned_to				'Bill'
  	task_type					'call'
    lead_for_task     'lead@example.com'
  end
end