# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tasking_event do
    extend Event::Factory

    taskee { FactoryGirl.build(:identifier, application: platform.application)
                        .resource_owner }
    due_date { Time.now + 5.minutes }
  end
end
