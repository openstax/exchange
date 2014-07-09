# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page_event do
    event_factory

    from "MyReferer"
    to "MyDestination"
  end
end
