# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message_event do
    to "MyText"
    cc "MyText"
    bcc "MyText"
    subject "MyText"
    body "MyText"
  end
end
