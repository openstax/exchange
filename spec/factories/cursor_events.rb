# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cursor_event do
    object "MyString"
    x_position 1
    y_position 1
    clicked false
  end
end
