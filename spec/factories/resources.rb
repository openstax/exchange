# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
    platform_id 1
    reference "MyString"
  end
end
