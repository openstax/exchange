# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :peer_grading_activity do
    extend Activity::Factory
    grader { SecureRandom.hex(32).to_s }
    grade "A+"
    feedback "This is my feedback."
  end
end
