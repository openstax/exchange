# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grading_event do
    event_factory

    grader "MyGrader"
    grader_type "Algorithm"
    grade "A"
    feedback "MyFeedback"
  end
end
