# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grading_event do
    extend Event::Factory

    grade "A"
    feedback "MyFeedback"
  end
end
