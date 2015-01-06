# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    platform
    person { FactoryGirl.build(:identifier,
               application: platform.application).resource_owner }
    resource { FactoryGirl.build(:resource) }
    trial { "#{SecureRandom.hex(32)}" }
  end
end
