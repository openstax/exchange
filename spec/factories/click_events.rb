# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :click_event do
    extend Event::Factory

    href "http://my.link.org"
  end
end
