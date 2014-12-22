# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :heartbeat_event do
    extend Event::Factory

    active true
  end
end
