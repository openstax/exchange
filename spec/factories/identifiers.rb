FactoryGirl.define do
  factory :identifier do
    application { FactoryGirl.build(:platform).application }
    expires_in 2.hours

    after(:build) do |identifier, evaluator|
      identifier.resource_owner = FactoryGirl.build(:person, identifier: identifier)\
        unless identifier.resource_owner
    end
  end
end