# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cursor_event do
    event_factory

    object "MyObject"
    x_position 42
    y_position 42
    clicked false
  end
end
