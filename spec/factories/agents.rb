# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :agent do
    extend User::Factory

    application
    is_manager false
  end
end
