# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    label "MyLabel"

    after(:build) do |person, evaluator|
      person.identifier = FactoryGirl.build(:identifier,
                                            resource_owner: person)\
        unless person.identifier
    end
  end
end
