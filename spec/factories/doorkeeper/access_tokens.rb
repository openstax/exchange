FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    application

    factory :identifier do
      application { FactoryGirl.build(:platform).application }
      association :resource_owner, factory: :person
      expires_in 2.hours
    end
  end
end
