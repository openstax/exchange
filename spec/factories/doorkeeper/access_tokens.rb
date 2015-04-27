FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    application
    scopes 'read write'
  end
end
