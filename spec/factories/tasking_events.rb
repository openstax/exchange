# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tasking_event do
    task
    tasker { SecureRandom.hex(32).to_s }
    due_date { Time.now + 5.minutes }
  end
end
