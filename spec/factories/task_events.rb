# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_event do
    number 1
    assigner_id ""
    assigner_type "MyString"
    due_date "2014-06-26 14:52:16"
    is_complete false
  end
end
