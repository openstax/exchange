# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :input_event do
    event_factory

    object "MyObject"
    category "free_response"
    data_type "text"
    data "MyFreeResponse"
  end
end
