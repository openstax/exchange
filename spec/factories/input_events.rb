# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :input_event do
    extend Event::Factory

    category "free_response"
    input_type "text"
    value "MyFreeResponse"
  end
end
