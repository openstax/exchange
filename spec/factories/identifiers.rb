# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identifier do
    platform
    person
    research_label { SecureRandom.hex(32) }

    after(:build) do |identifier|
      identifier.access_token ||= FactoryGirl.build(
        :access_token,
        application: identifier.platform.application,
        resource_owner: identifier
      )
    end
  end
end
