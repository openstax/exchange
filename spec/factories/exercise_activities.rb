# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise_activity do
    extend Activity::Factory
    grade "A+"
  end
end
