# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :load_event do
    task
    referer "http://my.referer.org"
  end
end
