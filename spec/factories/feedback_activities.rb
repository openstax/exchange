# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback_activity do
    extend Activity::Factory

    correct false
    grade "A"
    feedback "MyFeedback"
  end
end
