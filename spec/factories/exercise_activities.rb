# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise_activity do
    answer "a"
    correct false
    free_response "MyFreeResponse"
  end
end
