# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :peer_grading_activity do
    gradee_id ""
    grade "MyString"
    feedback "MyText"
  end
end
