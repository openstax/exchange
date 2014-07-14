# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_subscriber do
    event
    subscriber
  end
end
