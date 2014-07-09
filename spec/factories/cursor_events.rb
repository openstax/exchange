# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cursor_event do
    event_factory

    action "MyAction"
    href "http://www.example.com"
    x_position 42
    y_position 42
  end
end
