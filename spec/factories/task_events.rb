# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_event do
    number 1
    assigner "TeSR"
    assigner_type "algorithm"
    due_date {Time.now + 5.minutes}
    is_complete false
  end
end
