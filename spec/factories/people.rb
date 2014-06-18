# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    label "MyString"
    superseded_labels "MyText"
  end
end
