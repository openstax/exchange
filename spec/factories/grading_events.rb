# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grading_event do
    event_factory

    grader "MyGrader"
    grader_type "algorithm"
    grade "A"
    feedback "MyFeedback"
  end
end
