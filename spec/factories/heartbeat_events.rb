# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :heartbeat_event do
    task
    active true
  end
end
