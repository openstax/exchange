# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise_activity do
    extend Activity::Factory
    answer_type "free-response"
    answer "This is my Answer."
    correctness 1.0
  end
end
