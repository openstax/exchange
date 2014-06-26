# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback_activity do
    correct false
    grade "MyString"
    feedback "MyText"
  end
end
