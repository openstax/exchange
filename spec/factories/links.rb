# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    href { "https://www.google.com/?q=#{SecureRandom.hex(32)}" }
    source :other

    after(:build) do |link, evaluator|
      link.resource ||= FactoryGirl.build :resource, links_count: 0
      FindOrCreateResourceFromUrl::TRUSTED_HOSTS << Addressable::URI.parse(evaluator.href).host
    end
  end
end
