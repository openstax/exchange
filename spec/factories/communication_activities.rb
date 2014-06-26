# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :communication_activity do
    to ""
    cc ""
    bcc ""
    subject ""
    body "MyText"
  end
end
