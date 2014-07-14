# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reading_activity do
    extend Activity::Factory
  end
end
