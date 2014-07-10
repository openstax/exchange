# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page_event do
    extend Event::Factory

    from "http://my.referer.org"
    to "http://my.destination.org"
  end
end
