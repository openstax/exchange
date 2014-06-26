# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grading_event do
    grader_id ""
    grader_type "MyString"
    grade "MyString"
    feedback "MyText"
  end
end
