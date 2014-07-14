# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interactive_activity do
    extend Activity::Factory

    progress "MyProgress"
  end
end
