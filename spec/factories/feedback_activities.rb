# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback_activity do
    extend Activity::Factory
    grade "A+"
  end
end
