# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :agent do
    account_id 1
    application_id 1
    is_manager false
  end
end
