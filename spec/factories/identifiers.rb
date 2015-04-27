# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identifier do
    platform
    person
    analysis_uid { SecureRandom.hex(32) }

    after(:build) do |identifier|
      identifier.read_access_token ||= FactoryGirl.build(
        :access_token,
        application: identifier.platform.application,
        resource_owner: identifier,
        scopes: :read
      )

      identifier.write_access_token ||= FactoryGirl.build(
        :access_token,
        application: identifier.platform.application,
        resource_owner: identifier,
        scopes: :write
      )
    end
  end
end
