# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unload_event do
    task
    destination "http://my.destination.org"
  end
end
