FactoryGirl.define do
  factory :answer_event do
    extend Event::Factory

    answer "MyAnswer"
    answer_type "free-response"
  end
end
