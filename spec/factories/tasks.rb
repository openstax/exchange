# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    identifier
    resource
    trial { SecureRandom.hex(32).to_s }
  end
end
