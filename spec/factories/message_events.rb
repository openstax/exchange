# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message_event do
    extend Event::Factory

    sequence(:number)
    to "bob@example.com"
    cc "charlie@example.com"
    bcc "eve@example.com"
    subject "Hello"
    body "Hello World"
  end
end
