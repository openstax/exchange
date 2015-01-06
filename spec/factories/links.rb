# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    resource
    href { "https://www.google.com/?q=#{SecureRandom.hex(32)}" }
    rel "alternate"

    after(:build) do |link, evaluator|
      FindOrCreateResourceFromUrl::TRUSTED_HOSTS << URI(evaluator.href).host
    end
  end
end
