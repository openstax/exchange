# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :peer_grading_activity do
    extend Activity::Factory
    association :grader, factory: :identifier
    grade "A+"
    feedback "This is my feedback."
  end
end
