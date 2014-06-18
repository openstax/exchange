# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identifier do
    person_id 1
    platform_id 1
    value "MyString"
  end
end
