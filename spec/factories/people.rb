# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    transient do
      identifiers_count 3
    end

    after(:build) do |person, evaluator|
      evaluator.identifiers_count.times do
        person.identifiers << FactoryGirl.build(:identifier, person: person)
      end
    end
  end
end
