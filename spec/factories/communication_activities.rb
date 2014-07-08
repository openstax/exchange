# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :communication_activity do
    to "bob@example.com"
    cc "charlie@example.com"
    bcc "eve@example.com"
    subject "Hello"
    body "Hello World"
  end
end
