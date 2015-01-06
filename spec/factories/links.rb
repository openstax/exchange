# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    resource
    href { "https://www.example.org/#{SecureRandom.hex(32)}" }
    rel "alternate"
  end
end
