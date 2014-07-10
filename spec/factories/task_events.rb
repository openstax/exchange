# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_event do
    extend Event::Factory

    sequence(:number)
    association :assigner, factory: :person
    status :assigned
    due_date {Time.now + 5.minutes}
  end
end
