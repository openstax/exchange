# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :input_event do
    object "MyString"
    input_type "MyString"
    data_type "MyString"
    data "MyText"
    filename "MyString"
  end
end
