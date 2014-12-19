# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :input_event do
    extend Event::Factory

    input_type "text"
    value "MyFreeResponse"
  end
end
