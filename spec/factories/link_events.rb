# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link_event do
    task
    href "http://my.link.org"
  end
end
