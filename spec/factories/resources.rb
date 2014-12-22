# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
    url { "resource://#{SecureRandom.hex(32)}" }
  end
end
