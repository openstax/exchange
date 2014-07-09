# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :heartbeat_event do
    event_factory

    y_position 42
  end
end
