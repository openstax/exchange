# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grading_event do
    task
    grader { SecureRandom.hex(32).to_s }
    grade "A+"
    feedback "This is my feedback."
  end
end
