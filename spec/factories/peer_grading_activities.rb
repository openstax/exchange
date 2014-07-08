# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :peer_grading_activity do
    association :gradee, factory: :person
    grade "A"
    feedback "MyFeedback"
  end
end
