# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cursor_event do
    extend Event::Factory

    action "MyAction"
    href "http://my.link.org"
    x_position 42
    y_position 42
  end
end
